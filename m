Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTDTOqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTDTOqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:46:35 -0400
Received: from mail1.ewetel.de ([212.6.122.14]:51095 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263586AbTDTOqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:46:34 -0400
Date: Sun, 20 Apr 2003 16:58:23 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
In-Reply-To: <200304201432.h3KEWboQ000337@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0304201655530.1188-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, John Bradford wrote:

> > It's definitely CPU-related since it never happened with the Duron
> > processor that I used before.
> 
> Are you sure that the CPU voltage is correct?

The motherboard is in autodetect mode...

According to AMD's docs, my CPU wants 1.50V.
According to the BIOS, what it gets is 1.48V.

AMD does not specify a tolerance for Vcore, but I can try to manually
set the motherboard for 1.50V and see if the NMIs disappear.

-- 
Ciao,
Pascal

