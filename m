Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSGZFLW>; Fri, 26 Jul 2002 01:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGZFLV>; Fri, 26 Jul 2002 01:11:21 -0400
Received: from dsl-213-023-043-040.arcor-ip.net ([213.23.43.40]:13276 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316827AbSGZFLU>;
	Fri, 26 Jul 2002 01:11:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "jdow" <jdow@earthlink.net>, "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: [PATCH -ac] Panicking in morse code
Date: Fri, 26 Jul 2002 07:13:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Andrew Rodland" <arodland@noln.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020725084540.11202C-100000@gatekeeper.tmr.com> <E17Xw0V-0004f8-00@starship> <032001c23460$2f59e340$1125a8c0@wednesday>
In-Reply-To: <032001c23460$2f59e340$1125a8c0@wednesday>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17XxPT-0005N0-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 July 2002 06:52, jdow wrote:
> From: "Daniel Phillips" <phillips@arcor.de>
> > On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> > > ??? If the length is 1..5 I suspect you could use the top two bits and fit
> > > the whole thing in a byte. But since bytes work well, use the top three
> > > bits for length without the one bit offset. Still a big win over strings,
> > > although a LOT harder to get right by eye.
> >
> > Please read back through the thread and see how 255 different 7 bit codes
> > complete with lengths can be packed into 8 bits.
> 
> It appears someone is under the misapprehension that Morse characters are
> all 5 elements or less. "SK" is an example of a six element meta-character,
> one of a set that needs caring for, "...-.-".

Need I point out that we are now perfectly positioned to invent the additional
morse codes needed to represent all the remaining ascii characters?  We could
call the revised code... err... "remorse" ;-)

-- 
Daniel
