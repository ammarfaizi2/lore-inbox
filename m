Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291676AbSBNORW>; Thu, 14 Feb 2002 09:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291678AbSBNORI>; Thu, 14 Feb 2002 09:17:08 -0500
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:21259 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S291676AbSBNOQx>; Thu, 14 Feb 2002 09:16:53 -0500
Message-ID: <006101c1b562$23b39a40$0d2b0a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200202141021.LAA08331@harpo.it.uu.se> <20020214114856.B13643@stud.ntnu.no>
Subject: Re: inspiron 8100 freezing
Date: Thu, 14 Feb 2002 09:16:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mikael Pettersson:
> > I bet you have CONFIG_SMP or CONFIG_X86_UP_APIC enabled. In that
> > case the hangs on the Inspiron are expected: it's BIOS is buggy.
>
> Ok, what's wrong?  Just telling them something is wrong with their BIOS
> doesn't do much good :)

This seems to affect my Latitude C810 with the latest BIOS (A05).  When I
flashed to that version my linux system started handing at random spots.
Disabling CONFIG_X86_UP_APIC took care of the hangs, but I also lost all of
my battery status support (the batter would always say unknown).

I downgraded the system back to A04 and everything went back to normal.  So
I agree with this question, what's wrong with Dell's BIOS?  It seems that
whatever they do to get XP working breaks Linux badly.  I could complain,
but I'd need to be specific about what they are actually doing wrong.

Later,
Tom


