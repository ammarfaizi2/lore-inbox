Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSL2Ggt>; Sun, 29 Dec 2002 01:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSL2Ggt>; Sun, 29 Dec 2002 01:36:49 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:49354 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S266489AbSL2Ggs>; Sun, 29 Dec 2002 01:36:48 -0500
Date: Sun, 29 Dec 2002 01:44:52 -0500
From: Rahul Jain <rahul@rice.edu>
Subject: radeonfb.c has lots of undefined symbols
In-reply-to: <fa.c8kskov.1c0eqjr@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Message-id: <87hecxfhnf.fsf@localhost.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just decided to make the leap to 2.5, and in the process of compiling,
I hit a bug: Many of the PCI IDs are defined as .._RADEON_.. instead of
.._ATI_RADEON_.. as radeonfb.c has them and others aren't even defined
in any way that I can see. Also, there are a few other undefined symbols
in there. I don't use console much, so I just disabled the driver, but
I'm sure some people would appreciate if the driver at least
compiled. :)

--
Rahul Jain
