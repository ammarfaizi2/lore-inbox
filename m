Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCUT7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCUT7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:59:33 -0500
Received: from pop.gmx.de ([213.165.64.20]:65157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261197AbUCUT7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:59:32 -0500
X-Authenticated: #21910825
Message-ID: <405DF3C6.8050508@gmx.net>
Date: Sun, 21 Mar 2004 20:57:58 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Andi Kleen <ak@suse.de>,
       Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
References: <405DC698.4040802@pobox.com> <20040321165752.A9028@infradead.org> <405DE3EF.8090508@gmx.net> <20040321185538.A10504@infradead.org>
In-Reply-To: <20040321185538.A10504@infradead.org>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Mar 21, 2004 at 07:50:23PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>>Isn't that SuSE's strange ioctl hack that has been rejected for mainline
>>>multiple times?  why does x86_64 have an emulation for it if the ioctl
>>>isn't implemented anyway?
>>
>>Since this pops up from time to time, please let me explain what TIOCGDEV
>>does (if you know already, feel free to scoll to the end) and ask for
>>alternative solutions.
> 
> 
> Oh, I know what it does.  Have you ever looked at Al's rawconsole patch
> that he coded up exactly in response to that hack?
> 
> ftp://ftp.linux.org.uk/pub/people/viro/X0-rawconsole-B5

No. It was never announced on lkml, so I couldn't know of its existence.

Andi, Miquel: is the rawconsole patch usable for blogd?

Christoph: Have you looked at my question regarding
/sys/class/tty/console/dev ?


Regards,
Carl-Daniel

