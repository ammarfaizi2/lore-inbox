Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbRE2G1R>; Tue, 29 May 2001 02:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263217AbRE2G1H>; Tue, 29 May 2001 02:27:07 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:9265 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262733AbRE2G0y>; Tue, 29 May 2001 02:26:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: George France <france@handhelds.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jay Thorne <Yohimbe@userfriendly.org>
Subject: Re: PATCH - ksymoops on Alpha - 2.4.5-ac3 
In-Reply-To: Your message of "Tue, 29 May 2001 01:00:56 -0400."
             <01052901005607.17841@shadowfax.middleearth> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 May 2001 16:26:46 +1000
Message-ID: <4956.991117606@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 01:00:56 -0400, 
George France <france@handhelds.org> wrote:
>Could you send me an oops with the standard 'Code:' line? 

arch/mips/kernel/traps.c show_code() is a good example.  It prints

Code: xxxxxxxx xxxxxxxx xxxxxxxx <xxxxxxxx> xxxxxxxx xxxxxxxx

So it prints a few words either side of the failing instruction and
marks the failure by '<>'.

