Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTGVKLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGVKLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:11:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:39553 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270652AbTGVKLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:11:17 -0400
Date: Tue, 22 Jul 2003 11:36:07 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307221036.h6MAa7ER001757@81-2-122-30.bradfords.org.uk>
To: joern@wohnheim.fh-wedel.de, junkio@cox.net
Subject: Re: [PATCH] Port SquashFS to 2.6
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you look closely at the kernel, there is currently no way of
> telling whether it contains stack overflows waiting to happen, or not.

It would be an interesting experiment to deliberately make the kernel
stack smaller, and see what happens.  If no problems seem apparent
with a reduced kernel stack, it gives more weight to the argument that
the default one is OK.

John.
