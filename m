Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273000AbTHFLmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTHFLmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:42:50 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:42481
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S273000AbTHFLmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:42:49 -0400
Date: Wed, 6 Aug 2003 13:42:34 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (possible tty trouble)
Message-ID: <20030806114234.GD814@wind.cocodriloo.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com> <20030806022256.4b4f967c.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806022256.4b4f967c.dickson@permanentmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:22:56AM -0700, Paul Dickson wrote:
> On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:
> 
> > But all is not perfect.  I'll attach the problems I had as replies (so
> > each has it's own message thread).
> 
> I built 2.6.0-test2 for my Dell Inspiron 7000 notebook (PII, 300Mhz) with
> a RH9 distribution.  I build the kernel on another system (1.33GHz) using
> ssh.
> 
> I was missing some device support, so did a "make menuconfig".  The
> configuration options were shown, I selected "Sound -->" and pressed
> enter.  The terminal went back to text mode and then hung.  Gnome-terminal
> started consuming all unused CPU cycles.  
> 
> I could recover the process by closing the tab or resetting the terminal,
> but this would only fix the problem for the moment.  Frequently, it
> wouldn't even finish redisplaying the screen before it locked again.
> 
> This would happen running "make menuconfig" locally or via ssh on another
> system.
> 
> This is likely caused by some difference in the tty code in 2.6.0-test2.
> The problem does not occur under 2.4.20-18.9.  If 2.6.0-test2 is correct,
> then I might need an updated version of gnome-terminal suitable for 2.6.0.

This is a bug in gnome-terminal:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=89151

Greets, Antonio.

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
