Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVKQMbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKQMbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVKQMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:31:55 -0500
Received: from femail.waymark.net ([206.176.148.84]:2754 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1750783AbVKQMby convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:31:54 -0500
Date: 17 Nov 2005 12:17:14 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: linux-kernel@vger.kernel.org
Message-ID: <203b12.713227@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 16 Nov 05  14:40:16, Adrian Bunk wrote to All <=-

 AB> If one function calls another function you have to add the stack
 AB> usages.

these few may do that, i bet.
 0xc02bb528 huft_build:                                  1432
 0xc02bb954 huft_build:                                  1432
 0xc02bc1c4 inflate_dynamic:                             1312
 0xc02bc2ff inflate_dynamic:                             1312
 0xc02bc082 inflate_fixed:                               1168
 0xc02bc172 inflate_fixed:                               1168

78.5% of 493 make checkstack lines here report fewer than 200 bytes.
Only six over 600.

... Life is like a simile.
--- MultiMail/Linux v0.46
