Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTDYVGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTDYVGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:06:30 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61824 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264496AbTDYVGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:06:13 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304252121.h3PLLwSX002318@81-2-122-30.bradfords.org.uk>
Subject: 9-track tape drive (Was: Re: versioned filesystems in linux)
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 25 Apr 2003 22:21:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b8c2sh$tp0$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 25, 2003 12:38:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Of bigger concern is that the inter-block gap is only 0.5 (or maybe 0.75
> > inches, the memories are dim ;) - and you need to be able to stop and then get
> > back up to speed in that distance (or decelerate, rewind, and get a running
> > start).
> > 
> 
> No, you don't.  You just need to make sure you don't have the head
> active while you overshoot.  Performance will *definitely* suffer if
> you don't, though, since you'd have to rewind.

Well, we could make our device dual speed, and either run at E.G. 60
I.P.S. or 120 I.P.S. depending on whether we want to read a large
block of data, or just one block that happens to be closer to the
current head position than the distance we need to accellerate to 120
I.P.S.

John.
