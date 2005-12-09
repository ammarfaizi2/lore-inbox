Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVLII5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVLII5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 03:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVLII5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 03:57:06 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:38961 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbVLII5F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 03:57:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=svkZDgn9N+jcHD2vovOseuUN3QRi8nBfH8Ge1ujAHAEpzaCTma9smIZxbHYcRW+sqOra5IA2YP0n/bP3XcjaVOP07leetI/bLIOij8Tou3gUK+oYe/U83B1hD0OcYljnowN8V6g0tw4saBtHFuD4cUxwOBpdHANaFYr+HUgLiBQ=
Message-ID: <7a37e95e0512090057v5c2ab4cdwf1711144058cc77f@mail.gmail.com>
Date: Fri, 9 Dec 2005 14:27:04 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: recording with out getting into user space.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am writing a libata-complaint SATA driver for an ARM board.

I want to do data streaming from a tuner into the SATA hard disk.

In other words, I am getting a buffer of stream in kernel space, which
I had to store it in SATA hard disk.

Can I use filesystem (eg., XFS) to put the buffer into the SATA hard
disk without getting into user space.

What I mean, can I write an Linux Kernel Module to route data stream
from one device into SATA hard disk.

Thanks,
deven

--
"A smile confuses an approaching frown..."
