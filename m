Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289951AbSAPO20>; Wed, 16 Jan 2002 09:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289950AbSAPO2Q>; Wed, 16 Jan 2002 09:28:16 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:41670 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289951AbSAPO17>; Wed, 16 Jan 2002 09:27:59 -0500
Date: Wed, 16 Jan 2002 06:28:08 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <3C45858E.39F31DBA@didntduck.org>
Message-ID: <Pine.LNX.4.33.0201160612360.27975-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Brian Gerst wrote:

> Last I checked, Athlon XP's weren't certified for SMP, only MP's.
> That's likely what the problem is.  And for the record, Tyan also
> makes Intel boards too.
>
> Processor manufacturing 101:  All processors of a given family come
> off the same production line.  Due to variations in the process, some
> processors have defects that only show up at higher clock speeds, SMP
> mode, etc.  At the end of the line the processor is tested.  If it
> fails at higher clock speeds it is marked at a lower speed.  If it
> fails SMP it is marked as an XP.  Market demand can also cause a chip
> to be rated lower than it really is, so you can sometimes get away
> with overclocking, etc. but it's just random luck if it really works.


Could you be more specific on this "random luck" bit? Let's say we have
a production line making processors that should *all* run SMP at, say,
1800 MHz. What fraction of them will actually run SMP and 1800? What
fraction of them will actually run at 1800 UP? What fraction of them
will run at 1700 SMP, 1600 SMP, etc.? And what fraction of them run at
1800 SMP at the end of the line but croak when they get stuck in
<ducking> Aunt Tillie's motherboard?

I'm not looking for anyone's proprietary yield statistics here -- just a
rough idea of what kind of distributions we're dealing with here. For my
application, the 1.3 GHz Athlon I've got now is overkill. I wanted a
dual when I got the system last March, but there weren't any
motherboards available that I could find.

-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

Q. How do you tell when a pineapple is ready to eat?
A. It picks up its knife and fork.

