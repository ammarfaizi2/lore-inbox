Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTDZGlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 02:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbTDZGlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 02:41:14 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:49536 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264624AbTDZGlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 02:41:13 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304260657.h3Q6v0u7000394@81-2-122-30.bradfords.org.uk>
Subject: Re: 9-track tape drive (Was: Re: versioned filesystems in linux)
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 26 Apr 2003 07:57:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b8d952$162$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 25, 2003 11:32:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > actually measure the real speed you can presumably vary the speed
> > > arbitrarily, all the way up to the breaking point of the medium.
> > 
> > I suspect that method is patented, as I have seen this implemented on
> > both Travan tapes, and cassette tapes.
> > 
> > However, there seems to have been a flaw in the implementation, where the
> > breaking point was underestimated.
> > 
> 
> Presumably any patents on this have since long expired (they would
> have had to have been filed no earlier than 1983.)

Using two heads, you should be able to write at variable speed as well
- if the heads are spaced two blocks apart, whatever speed you read a
block at with the first head, you could write the new data using the
second head at the same speed.

As long as the tape is formatted correctly, it should work.

John.
