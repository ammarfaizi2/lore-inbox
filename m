Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132048AbRCVPAA>; Thu, 22 Mar 2001 10:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132047AbRCVO7l>; Thu, 22 Mar 2001 09:59:41 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:37388 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S132037AbRCVO7c>;
	Thu, 22 Mar 2001 09:59:32 -0500
Date: Thu, 22 Mar 2001 15:59:34 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Neal Gieselman <Neal.Gieselman@Visionics.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where is the RAM?
In-Reply-To: <D0FA767FA2D5D31194990090279877DA5736B2@dbimail.digitalbiometrics.com>
Message-ID: <Pine.LNX.4.30.0103221557340.19009-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Neal Gieselman wrote:

> I have a Redhat 6.1 WS that was installed with 64 MB RAM.  I added another
> 64 MB, booted, BIOS sees it, but top, free, etc still see only 64 MB.
> Any clues on what to do?

Add mem=128M (or mem=127M if that fails) to the boot line (append in
LILO), or upgrade the kernel to something recent.

/Tobias


