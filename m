Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHPQiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHPQiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUHPQiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:38:14 -0400
Received: from 130.67-18-18.reverse.theplanet.com ([67.18.18.130]:52962 "EHLO
	server3.imagelinkusa.net") by vger.kernel.org with ESMTP
	id S267766AbUHPQiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:38:11 -0400
Subject: growisofs stopped working with 2.6.8
From: "Tony A. Lambley" <tal@vextech.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092674287.3021.19.camel@bony>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 12:38:08 -0400
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: vextech
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server3.imagelinkusa.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - vextech.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, burning a dvd iso now fails :(

$ growisofs -Z /dev/hdc=file.iso
:-( unable to GET CONFIGURATION: Operation not permitted
:-( non-MMC unit?

Reverting back to 2.6.7 allows burning to work again. I've googled and
it would appear I'm not the only one with this.

Does anyone have any ideas why this would be happening?



