Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289930AbSAPNv3>; Wed, 16 Jan 2002 08:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289931AbSAPNvU>; Wed, 16 Jan 2002 08:51:20 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:25239 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S289930AbSAPNvN>; Wed, 16 Jan 2002 08:51:13 -0500
Message-ID: <3C45858E.39F31DBA@didntduck.org>
Date: Wed, 16 Jan 2002 08:52:14 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <1010925802.674.0.camel@sector17.home.at> 
		<3C44BB1B.E1F3318C@didntduck.org> <1011181530.513.0.camel@sector17.home.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Thalinger wrote:
> 
> On Wed, 2002-01-16 at 00:28, Brian Gerst wrote:
> > What CPU do you have?  Do you have the FPU emulator compiled in?  Are
> > there any oops messages?
> >
> > --
> >                                               Brian Gerst
> >
> 
> I mentioned in my first mail the dual tyan, so athlon xp, no fpu
> emulator ;-) and no oops messages.

Last I checked, Athlon XP's weren't certified for SMP, only MP's. 
That's likely what the problem is.  And for the record, Tyan also makes
Intel boards too.

Processor manufacturing 101:  All processors of a given family come off
the same production line.  Due to variations in the process, some
processors have defects that only show up at higher clock speeds, SMP
mode, etc.  At the end of the line the processor is tested.  If it fails
at higher clock speeds it is marked at a lower speed.  If it fails SMP
it is marked as an XP.  Market demand can also cause a chip to be rated
lower than it really is, so you can sometimes get away with
overclocking, etc. but it's just random luck if it really works.

-- 

						Brian Gerst
