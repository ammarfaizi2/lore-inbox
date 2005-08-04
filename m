Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVHDQij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVHDQij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVHDQf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:35:28 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:4633 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262602AbVHDQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:33:47 -0400
X-OUTRCPT-TO: from-linux-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org
X-OUTMAIL-FROM: mdomsch@lists.us.dell.com
X-IronPort-AV: i="3.95,167,1120453200"; 
   d="scan'208"; a="294578220:sNHT16929710"
Date: Thu, 4 Aug 2005 11:33:46 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Could you please check mail configuration?
Message-ID: <20050804163346.GA22026@lists.us.dell.com>
References: <200508042245.IEC40094.631911@I-love.SAKURA.ne.jp> <20050804140543.GA16674@lists.us.dell.com> <200508050030.BIJ05555.PtJGMVOLSFSYFMOtN@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508050030.BIJ05555.PtJGMVOLSFSYFMOtN@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:31:10AM +0900, Tetsuo Handa wrote:
> Hello, Matt.
> 
> > I had a note from you that this was a configuration error on your
> > server's part, not on the list.  So I stopped worrying about it...
> Oh, really? I'm sorry.
> 
> What is funny is that ...
> 
> The mail from Matt had a X-OUTRCPT-TO header
> with 2 mail addresses (my address and this ml's address),
> but the mail from Jesper didn't have the X-OUTRCPT-TO header,
> although both mails are sent as a reply to my mail.
> 
> The X-OUTRCPT-TO: header in a Linux-kernel-daily-digest Digest
> contains 80 mail addresses including my address.
> 
> I can find X-OUTRCPT-TO header only in mails from
> Matt and Linux-kernel-daily-digest Digest.
> 
> You say this is a configuration error on my server's part.
> I thought this X-OUTRCPT-TO header is added at linux.us.dell.com
> and delivered to 80 recipients, resulting 80 recipients can see
> other 79 addresses.

It is indeed a mistake on Dell's part, and it'll be fixed
momentarily.  lists.us.dell.com relays to an intermediate server
before being sent to you, and the intermediate relay was adding that
field incorrectly.  Thanks for bringing it to my attention.

-Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
