Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSLOVUB>; Sun, 15 Dec 2002 16:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLOVUB>; Sun, 15 Dec 2002 16:20:01 -0500
Received: from [81.2.122.30] ([81.2.122.30]:65290 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262807AbSLOVUB>;
	Sun, 15 Dec 2002 16:20:01 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212152139.gBFLdI1p002059@darkstar.example.net>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
To: marvin@synapse.net (D.A.M. Revok)
Date: Sun, 15 Dec 2002 21:39:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212151549.37661.marvin@synapse.net> from "D.A.M. Revok" at Dec 15, 2002 03:49:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> have to use the power-switch to get the machine back

If you have another terminal accessible, you could try:

hdparm -w /dev/hda

to reset the interface.  I can't guarantee that it wouldn't loose
data, though.

John.
