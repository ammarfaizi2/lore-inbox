Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbTDVC0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTDVC0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:26:21 -0400
Received: from lucidpixels.com ([66.45.37.187]:22150 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262837AbTDVC0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:26:21 -0400
Date: Mon, 21 Apr 2003 22:38:23 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p300
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20 + SiS + Adaptec AHA-7850
Message-ID: <Pine.LNX.4.55.0304212236380.12135@p300>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does not work...
Boots up, probes each ID, fails, takes 15-20 sec per timeout for each ID,
then actually does boot after (15-20sec)*7ID for that board.

I used same exact (SCSI-CONFIG) for VIA board, worked fine, guess there
are problems with IRQs or something?

I'd send log/more information but don't feel like writing 10 pages of text
down to send to lkml.


