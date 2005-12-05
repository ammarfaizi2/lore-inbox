Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLEAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLEAcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 19:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVLEAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 19:32:12 -0500
Received: from torrent.CC.McGill.CA ([132.206.27.49]:32945 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932310AbVLEAcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 19:32:12 -0500
Subject: echo "mem" > /sys/power/state fails
From: David Ronis <ronis@montroll.chem.mcgill.ca>
Reply-To: David.Ronis@McGill.CA
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Chemistry Department, McGill University
Date: Sun, 04 Dec 2005 19:31:40 -0500
Message-Id: <1133742700.6492.3.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a HP laptop (a Pavilion ZV5240CA) running a 2.6.12.6 kernel.
This as a pentium 4 hyperthreaded chip.

cat /sys/power/state gives:  standby mem disk 

echo mem > /sys/power/state as root does nothing.  Nothing appears in
the logs either.

Any suggestions?


David


