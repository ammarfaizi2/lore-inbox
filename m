Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVGXOCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVGXOCO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVGXOCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:02:14 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:58199 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261229AbVGXOCM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:02:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IeZpYKaV0ocnqXdzxoRW54dWlcyU6hoZHrziUbCNoxH+YLQ6r79O1er8jGepSEqLpOnH2QfBSW7LB4uYwY7b8K5nQ3Rt/wckpkrg7AkANXRdwfVzqtH/oxa5JLwY6arBzCMIPoCTyhuPhI8wVAIs0eH6HL4np18KkS0XfZpcq+I=
Message-ID: <9a8748490507240702593372d4@mail.gmail.com>
Date: Sun, 24 Jul 2005 16:02:12 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: UmaMaheswari Devi <uma@cs.unc.edu>
Subject: Re: kernel debugging
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42E3946E.4010009@cs.unc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E3946E.4010009@cs.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, UmaMaheswari Devi <uma@cs.unc.edu> wrote:
> I am new to kernel hacking and am facing problems in trying to peek at the
> runtime values of some kernel variables using gdb.
> 
> I am issuing the gdb command as follows:
>      gdb vmlinux /proc/kcore
> This displays the message
>     /proc/kcore: Operation not permitted
> before the (gdb) prompt is displayed.
> gdb then prints a value of 0 for any valid variable that is requested.
> 
> vmlinux appears to be OK, as gdb correctly identifies undefined variables.
> The problem seems to be with /proc/kcore. This file has a permission of 400. I
> am using the Red Hat distribution.
> 
> Any help is appreciated.
> 
If you want to use gdb to debug the kernel you should probably
investigate UML (User Mode Linux). Take a look at this link :
http://user-mode-linux.sourceforge.net/debugging.html

Alternatives include kgdb - http://kgdb.sourceforge.net/ 
and kdb - http://oss.sgi.com/projects/kdb/

You can also find many documents on Linux Kernel debugging aids and
techniques via google.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
