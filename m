Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKEREz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKEREz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVKEREz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:04:55 -0500
Received: from outbound01.telus.net ([199.185.220.220]:52952 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750727AbVKEREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:04:54 -0500
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/25] compat: Remove leftovers from register_ioctl32_conversion
Date: Sat, 5 Nov 2005 18:04:48 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162710.209305000@b551138y.boeblingen.de.ibm.com>
In-Reply-To: <20051105162710.209305000@b551138y.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051804.48744.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 17:26, Arnd Bergmann wrote:
> We don't need the semaphore any more since we no longer
> write to the ioctl32 hash table while the kernel is running.

Yes good patch. In fact I had a similar patch in one of my trees
for a long time, just didn't get around to submit it yet.

-Andi
