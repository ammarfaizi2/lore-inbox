Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284638AbRLPO0r>; Sun, 16 Dec 2001 09:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284639AbRLPO0i>; Sun, 16 Dec 2001 09:26:38 -0500
Received: from ns.suse.de ([213.95.15.193]:19725 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284638AbRLPO0b>;
	Sun, 16 Dec 2001 09:26:31 -0500
Date: Sun, 16 Dec 2001 15:26:30 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <4.3.2.7.2.20011216091040.00d7c180@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.33.0112161523360.876-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, David Relson wrote:

> IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed a
> suitable "release candidate" test - available for a couple of days and
> nobody has found any major problems.

Except for loop deadlock, sysvfs oops, and a glut of __devexit
non-compiles. Whilst the sysvfs oops shouldn't affect many, loop
is used by a lot of people, and the __devexit patches would save
us another month of debian sid users who don't bother to read archives.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

