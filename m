Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286860AbRL1MMx>; Fri, 28 Dec 2001 07:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286858AbRL1MMo>; Fri, 28 Dec 2001 07:12:44 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5904 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286860AbRL1MMd>; Fri, 28 Dec 2001 07:12:33 -0500
Date: Fri, 28 Dec 2001 13:12:28 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011228121228.GA9920@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Roy Hills wrote:

> I'm using linux kernel 2.2.20 on my systems.  This works fine as a
> bzImage which most of my systems use, however one of my systems
> (a Toshiba Tecra laptop) needs to use zImage, and I find that 2.2.20
> does not work in this case, although previous versions e.g. 2.2.17 do.

Did your kernel grow (configuration change)? zImage has tighter size
limits than bzImage. Did you actually make zImage or did you just to
make? The (b)zImage is in arch/i386/boot/

-- 
Matthias Andree
