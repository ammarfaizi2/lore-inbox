Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTKRAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKRAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:45:26 -0500
Received: from aeimail.aei.ca ([206.123.6.14]:61137 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261735AbTKRApV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:45:21 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: CONFIG_CRC32 in 2.4.22 breaks PCMCIA
Date: Mon, 17 Nov 2003 19:45:47 -0500
User-Agent: KMail/1.5.93
Cc: Andrew Pimlott <andrew@pimlott.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20031117200451.GA12931@pimlott.net> <Pine.LNX.4.44.0311172121400.3939-100000@gaia.cela.pl> <20031117204039.GB12931@pimlott.net>
In-Reply-To: <20031117204039.GB12931@pimlott.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311171945.47655.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 17, 2003 03:40 pm, Andrew Pimlott wrote:
> > Well, it's in the help for the CRC32 option that it's available to enable
> > external-kernel tree drivers to access these functions.  If you are
> > running make oldconfig you'll hit the question and if you don't know what
> > it's about you should consult help...
>
> I think I used xconfig the first time I configured this kernel
> (because I coincidentally wanted to change something).  It was a
> while ago, and I only tried pcnet_cs today, so my memory isn't
> perfect.  Maybe I should have used oldconfig first, but I doubt
> everyone else does that for stable kernels.
>
> It still seems unwise to change the default in a stable kernel.  Let
> the people who want it set CONFIG_OMIT_CRC32 or something.

Andrew,

I think its reasonable to have to do a make oldconfig for stable kernels.
Stable does not mean new drivers and/or filesystems do not get added...

Ed Tomlinson
