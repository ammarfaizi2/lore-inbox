Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVCQJmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVCQJmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVCQJmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:42:19 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:17090 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262591AbVCQJmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:42:15 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm4
Date: Thu, 17 Mar 2005 10:42:33 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org> <200503170942.25833.petkov@uni-muenster.de> <20050317011811.69062aa0.akpm@osdl.org>
In-Reply-To: <20050317011811.69062aa0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171042.33558.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2005 10:18, Andrew Morton wrote:
> Borislav Petkov <petkov@uni-muenster.de> wrote:
> > Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
> >  Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk failed.
> >  Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root (ext2
> > filesystem) readonly. Mar 17 09:19:28 zmei kernel: [    4.112465] Freeing
> > unused kernel memory: 188k freed Mar 17 09:19:28 zmei kernel: [   
> > 4.142002] logips2pp: Detected unknown logitech mouse model 1 Mar 17
> > 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on
> > isa0060/serio1 [EOF]
> >  <-- and here it stops waiting forever. What actually has to come next is
> > the init process, i.e. something of the likes of:
> >  INIT version x.xx loading
> >  but it doesn't. And by the way, how do you debug this? serial console?
>
> Serial console would be useful.  Do sysrq-P and sysrq-T provide any info?
Hmm, 
actually I haven't set up a serial console connection so let me try to 
establish one first and get back to you whenever I have some results.

Boris.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
