Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263932AbRFENZA>; Tue, 5 Jun 2001 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263973AbRFENYu>; Tue, 5 Jun 2001 09:24:50 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:32004 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263932AbRFENYi>;
	Tue, 5 Jun 2001 09:24:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Arthur Naseef" <arthur.naseef@ariel.com>
cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14 
In-Reply-To: Your message of "Tue, 05 Jun 2001 09:10:56 -0400."
             <OIBBKHIAILDFLNOGGFMNOEHLCBAA.arthur.naseef@ariel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Jun 2001 23:24:33 +1000
Message-ID: <16891.991747473@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 09:10:56 -0400, 
"Arthur Naseef" <arthur.naseef@ariel.com> wrote:
>I still have not figured out the magic that creates the .ver files which
>would resolve your concern with the symbol versions, but I do know that
>you can edit the .ver file yourself (under /usr/src/linux/include/modules/)
>and add entries.  This will eliminate the funny versioning, as in:
>
>    grab_timer_interrupt_R__ver_grab_timer_interrupt
>
>You can pick a hash value to use.  For example, you might add the following:
>
>	#define __ver_grab_timer_interrupt	a1b2c3d4
>	#define grab_timer_interrupt	_set_ver(grab_timer_interrupt)

Remind me _NEVER_ to answer any of your module problems.  Make up your
own hash indeed, complete and utter rubbish!

