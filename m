Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274846AbRIZGf4>; Wed, 26 Sep 2001 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274848AbRIZGfq>; Wed, 26 Sep 2001 02:35:46 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:59917 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S274846AbRIZGf3>; Wed, 26 Sep 2001 02:35:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: <linux-kernel@vger.kernel.org>
Subject: ac15 make install problems
Date: Wed, 26 Sep 2001 02:35:55 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010926063535Z274846-760+17000@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that if you run make install more than twice, it deletes the .old 
files instead of appending another .old to them. 
Also, setting an alternate install directory via the install path variable in 
the Makefile has no effect. 
