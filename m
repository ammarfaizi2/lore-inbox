Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbTADOKo>; Sat, 4 Jan 2003 09:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTADOKo>; Sat, 4 Jan 2003 09:10:44 -0500
Received: from daimi.au.dk ([130.225.16.1]:6272 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S266927AbTADOKn>;
	Sat, 4 Jan 2003 09:10:43 -0500
Message-ID: <3E16ED5D.425E4DE4@daimi.au.dk>
Date: Sat, 04 Jan 2003 15:19:09 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.54
References: <20030104140643.19228.qmail@linuxmail.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> From: Kasper Dupont <kasperd@daimi.au.dk>
> >
> > How many versions do you have to go backwards to find a kernel
> > you can compile?
> 
> Just one :-) 2.5.53 is happily running on my laptop.
> I think I've compiled and booted all the kernel version
> since 2.5.3something.

A closer look on the patch reveals that the lines causing
trouble for you are in fact new:
http://www.kernel.org/diff/diffview.cgi?css=%2Fdiff%2Fdiff.css;file=%2Fpub%2Flinux%2Fkernel%2Fv2.5%2Fpatch-2.5.54.gz;z=65
And so are the fields being manipulated:
http://www.kernel.org/diff/diffview.cgi?css=%2Fdiff%2Fdiff.css;file=%2Fpub%2Flinux%2Fkernel%2Fv2.5%2Fpatch-2.5.54.gz;z=862

Could the compiler somehow be using headers from the
wrong location? (Just a wild guess)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
