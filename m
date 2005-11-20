Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVKTBXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKTBXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVKTBXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:23:51 -0500
Received: from freelists-180.iquest.net ([206.53.239.180]:33156 "EHLO
	turing.freelists.org") by vger.kernel.org with ESMTP
	id S1751053AbVKTBXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:23:50 -0500
From: John Madden <weez@freelists.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS: clm-2201: last flush, clm-2200: last commit
Date: Sat, 19 Nov 2005 20:23:49 -0500
User-Agent: KMail/1.8.3
References: <200511122252.21366.weez@freelists.org>
In-Reply-To: <200511122252.21366.weez@freelists.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511192023.49750.weez@freelists.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 10:52 pm, John Madden wrote:
> ReiserFS: dm-5: warning: clm-2200: last commit 2158066944, current
> 2158066945 ReiserFS: dm-5: warning: clm-2201: last flush 2158065946,
> current 2158065947
>
> This is on both 2.6.12.5 (last night) and 2.4.14.1 as of tonight.  fsck
> reports no corruption and I have no reason other than these warnings to
> believe there is any, but this is (obviously) troubling nonetheless.  The
> relevant code is in fs/reiserfs/journal.c.  

FWIW, I've given up on this and moved the data to another filesystem on the 
same box, now with no further errors.  I hope at some point someone finds out 
what causes what I can only assume to be filesystem trashing -- trashing that 
fsck doesn't find.

John




-- 
# John Madden  weez@freelists.org: http://www.nerdarium.com
# FreeLists: Free mailing lists for all: http://www.freelists.org
# Linux, Apache, Perl and C: All the best things in life are free!
