Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRKDD2t>; Sat, 3 Nov 2001 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRKDD2j>; Sat, 3 Nov 2001 22:28:39 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:407 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278085AbRKDD2d>; Sat, 3 Nov 2001 22:28:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Google's mm problems
Date: Sun, 4 Nov 2001 04:29:39 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011103205601.2170.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20011103205601.2170.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104032828Z16097-4784+757@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 3, 2001 09:56 pm, Christian Ehrhardt wrote:
> On Wed, Oct 31, 2001 at 12:07:17AM +0100, Daniel Phillips wrote:
> > Hi, I've been taking a look on a mm problem that Ben Smith of Google posted 
> > a couple of weeks ago.  As it stands, Google can't use 2.4 yet because all
> > known flavors of 2.4 mm fall down in one way or another.  This is not good.
> 
> Andrea suggested that this might be a mlock bug and someone else
> pointed out that madvise instead of mlock exhibits similar behaviour.
> So I looked at this code and this patch looks obviously correct:

I'm pretty sure at this point that it's just poor balancing between zones.  To
test this, Ben tried it highmem config'ed off and ran without problems (2/2G
user/kernel split).

--
Daniel
