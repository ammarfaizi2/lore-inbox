Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270455AbTHQSFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270461AbTHQSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:05:49 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:36993 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270455AbTHQSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:05:48 -0400
Date: Sun, 17 Aug 2003 19:17:28 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308171817.h7HIHSV4001111@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, rbrandonstewart@yahoo.com
Subject: Re: Hot swapping USB mouse in X window system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd appreciate hearing from anyone who has experienced similar, or knows 
> if there is a way to work around this.

Either configure X to use /dev/input/mice and create /dev/input/mice if it doesn't exist using:

mknod /dev/input/mice c 13,63

or use the virtual ps/2 device.

John.
