Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133039AbRDLBoe>; Wed, 11 Apr 2001 21:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRDLBoZ>; Wed, 11 Apr 2001 21:44:25 -0400
Received: from mercury.mv.net ([199.125.85.40]:45573 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S133039AbRDLBoP>;
	Wed, 11 Apr 2001 21:44:15 -0400
Message-ID: <002701c0c2f1$fc672960$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: <esr@thyrsus.com>
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com>
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Date: Wed, 11 Apr 2001 21:43:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused.  Downloaded cml2-1.0.0 installed ran it....appear to work but
it doesn't remember my changes.  Just now, I updated to 1.0.3 and it
reported cleaning up existing files.  Ran "make config" and it popped up
menu under X.  Then I changed the "config policy options" to "expert,
wizard, tuning" and exited with "save and exit".

Then re-opened with make config and nothing changed...expert, wizard and
tuning not set.  Maybe the program _knows_ I'm not a wizard but it should at
least let me _tune_.  (joke)

By the way "make editconfig" shows the changes made under "make config" and
allows me to make more changes..

The READ.ME says that "make config" will run configtrans to generate
.config.  But that doesn't explain why "make config"  doesn't remember
changes made to config.out.

ideas?

jeff

