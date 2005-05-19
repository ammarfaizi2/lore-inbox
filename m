Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVESDLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVESDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVESDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:11:09 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:32742 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262465AbVESDKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:10:51 -0400
Date: Wed, 18 May 2005 23:10:49 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: 2.6.12-rc4-mm[12] - ULOG problem
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Mail-followup-to: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <20050519031049.GA18130@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipt_ULOG fails to load starting from 2.6.12-rc4-mm1 with the following
error message:


FATAL: Error inserting ipt_ULOG (/lib/modules/2.6.12-rc4-mm1-2/kernel/net/ipv4/netfilter/ipt_ULOG.ko): Cannot allocate memory

rc3-mm3 works fine.

Unfortunately, I wont have time to do a binary search till the weekend,
but I hope you'll point suspicious patch(es) without it.

Any additional info available by request.

-- 
With best wishes,
	Nick Orlov.

