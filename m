Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRHaPhM>; Fri, 31 Aug 2001 11:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbRHaPhC>; Fri, 31 Aug 2001 11:37:02 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:47625 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266827AbRHaPgw>; Fri, 31 Aug 2001 11:36:52 -0400
Date: 31 Aug 2001 10:04:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <87ut6YAmw-B@khms.westfalen.de>
In-Reply-To: <20010830171934Z16012-32384+1116@humbolt.nl.linux.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200108301703.TAA05549@nbd.it.uc3m.es> <200108301703.TAA05549@nbd.it.uc3m.es> <20010830171934Z16012-32384+1116@humbolt.nl.linux.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net (Daniel Phillips)  wrote on 30.08.01 in <20010830171934Z16012-32384+1116@humbolt.nl.linux.org>:

> On August 30, 2001 07:03 pm, Peter T. Breuer wrote:
> > "Daniel Phillips wrote:"
> > > More than anything, it shows that education is needed, not macro
> patch-ups.
> > > We have exactly the same issues with < and >, should we introduce
> > > three-argument macros to replace them?
> >
> > # define le(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _a ; })
> > # define ge(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _b ; })
>
> Oh, you are one sick puppy.
>
> For completeness:
>
> # define lt(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) != _b ; })
> # define gt(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) != _a ; })

Does it give the right answers for floating point?


MfG Kai
