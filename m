Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTA0UgC>; Mon, 27 Jan 2003 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTA0UgC>; Mon, 27 Jan 2003 15:36:02 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:56993 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S262806AbTA0UgB>; Mon, 27 Jan 2003 15:36:01 -0500
Date: Mon, 27 Jan 2003 12:45:07 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Emmett Pate <emmett@epate.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Status of Modules?
Message-ID: <20030127204507.GA17737@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200301270743.15588.emmett@epate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301270743.15588.emmett@epate.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Along with Rustys new module-init-tools (required to get started - I
downloaded mine from
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/ ) I had to apply
this patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104284883805276&w=2 to make
modules on 2.5.59 load without hard locking my kernel. I believe there's
newer/better versions of this fix on the list -- you might want to check the
archives.
	--Mark

On Mon, Jan 27, 2003 at 07:43:15AM -0500, Emmett Pate wrote:
> What's the status of the module loading code?  I've been compiling them into 
> the kernel since something around 2.5.3x when the code was rewritten.  I'd 
> like to begin using a few modules again (especially some PCMCIA stuff).  Is 
> there any documentation explaining what will be necessary for 2.5 to use 
> modules?
> 
> Thanks for the help,
> Emmett Pate
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com
