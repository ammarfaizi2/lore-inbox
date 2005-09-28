Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVI1VzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVI1VzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVI1Vyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:44 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41733 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751030AbVI1VyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:17 -0400
Date: Wed, 28 Sep 2005 17:50:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
Subject: [patch 2.6.14-rc2 0/3] HD audio realtek codec fixes
Message-ID: <09282005175052.10882@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some simple fixes in patch_realtek.c.

	-- Fix the "sex" of the ALC260 "Mono Playback Switch"

	-- Fix a type in alc880_test_mixer

	-- Fix the "sex" of the ALC882 "LFE Playback Switch"

The last one is speculative based on the datasheet and experience with
the ALC260.  Anyone with ALC882 hardware is invited to test and
confirm.

Patches to follow...
