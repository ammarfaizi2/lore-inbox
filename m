Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSGTGf4>; Sat, 20 Jul 2002 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSGTGf4>; Sat, 20 Jul 2002 02:35:56 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:7301 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317385AbSGTGfz>; Sat, 20 Jul 2002 02:35:55 -0400
Date: Fri, 19 Jul 2002 23:36:40 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [PATCH 6/6] Updated VM statistics patch
In-Reply-To: <Pine.LNX.4.44.0207190154390.4647-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.44.0207192328330.5880-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This latest version takes advantage of the list management macros in 
mm_inline.h to handle all of the 'pgactivate' and 'pgdeactivate' 
counter incrementing.  This simplifies the patch, and makes it easier to 
keep accounting accurate.

	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.26/
	[ 2.5.26-rmap-6-VMstats2 19-Jul-2002 23:27    10k ]

Craig Kulesa
Steward Obs.
Univ. of Arizona

