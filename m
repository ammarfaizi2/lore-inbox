Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWGNJi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWGNJi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGNJi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:38:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45885 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161005AbWGNJi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:38:58 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] Shrink struct request
Date: Fri, 14 Jul 2006 11:41:53 +0200
Message-Id: <11528701161633-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset applies on top of what was sent yesterday. It shrinks
the size of struct request from 320 to 296 bytes on x86-64 by cleaning
up code and removing dead code.

-- 
Jens Axboe

