Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTJZRsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTJZRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:48:50 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:26376 "EHLO
	cygnus-ext.enyo.de") by vger.kernel.org with ESMTP id S263376AbTJZRss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:48:48 -0500
Date: Sun, 26 Oct 2003 18:49:01 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test9] Strange SCSI messages
Message-ID: <20031026174901.GA12371@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see these two errors (issued at the same time) in the kernel log file:

| Info fld=0x440b6b, Current sdsdd: sense key Recovered Error
| Additional sense: Address mark not found for data field

According to the sources, these are SCSI messages (matbe this should be
noted in the message?) -- but what do they mean?
