Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJNRbT>; Mon, 14 Oct 2002 13:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJNRbT>; Mon, 14 Oct 2002 13:31:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10951 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261972AbSJNRbS>;
	Mon, 14 Oct 2002 13:31:18 -0400
Subject: Re: Linux v2.5.42
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF8EE253F8.C354E34A-ON85256C52.005B9938@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Mon, 14 Oct 2002 12:37:04 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/14/2002 01:37:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Oct 2002, Rik van Riel wrote:

>All you need is:
>
>1) a kernel level driver that can map devices, ie. a device mapper
>
>2) user space tools that can parse the volume metadata and tell the
>   kernel how to map each chunk at initialisation or mount time

This works well for the simple cases where the volume metadata is
static.  However, it does not handle cases where the volume
metadata must be updated dynamically, the most obvious cases
being striping with parity, mirroring (esp. the more advanced
forms/features such as smart resync, partial mirrors, remote
mirroring, etc), snapshots, and bad block relocation.

Regards,

Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


