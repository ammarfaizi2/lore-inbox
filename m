Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBDLzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBDLzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVBDLzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:55:40 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:40407 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261166AbVBDLu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:50:57 -0500
Date: Fri, 4 Feb 2005 12:51:54 +0100
From: DervishD <lkml@dervishd.net>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Huge unreliability - does Linux have something to do with it?
Message-ID: <20050204115154.GB625@DervishD>
Mail-Followup-To: jerome lacoste <jerome.lacoste@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2cf1f605020401037aa610b9@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jerome :)

 * jerome lacoste <jerome.lacoste@gmail.com> dixit:
> [Sorry for the sensational title]

    It catched my attention ;)))
 
> I halted the machine correctly yesterday night. I never dropped the
> box in 3 years. Am I just being unlucky? Or could the fact that I am
> using Linux on the box affect the reliability in some ways on that
> particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
> computers and never had single problems with them.

    Well, Linux may stress the hardware more than other operating
systems because it tries to optimize usage and performance. But in
this particular case I will think you are very unlucky O:) I've seen
that before, unfortunately.
 
> Could a hardware failure look like bad sectors to fsck?

    Yes, depending on the hardware failure.

> (*) I accept tips on discovering and maybe recovering which files have
> been taken out of my system...

    You should use 'integrit' (http://integrit.sourceforge.net). I
use it to know whether a file whose contents shouldn't change has
changed, but it has more usages. And use memtest86 (there are two
versions out there) to check your RAM, just in case. Bad RAM can
cause 'apparent' hardware failures. A bad RAM chip can cause disk
errors (if you write to disk from *bad* RAM, you'll write *bad* data)
and other failures. Use 'integrit', read the documentation for
details.

    Good luck, you'll need it with that laptop :(

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
