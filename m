Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTIVUDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTIVUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:03:34 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:18816 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263196AbTIVUDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:03:31 -0400
Date: Mon, 22 Sep 2003 21:03:08 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309222003.h8MK38kC000353@81-2-122-30.bradfords.org.uk>
To: arjanv@redhat.com, ebiederm@xmission.com
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Cc: alan@lxorguk.ukuu.org.uk, jamie@shareable.org,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another reason for fixing this is we are killing who knows how much
> I/O bandwidth with this stream of failing writes to port 0x80.

Assuming we do stop using I/O to port 0x80 for timing purposes, would
it be worth adding code to make existing POST cards double as a poor
man's front panel display once the kernel has booted?

John.
