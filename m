Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRINTVX>; Fri, 14 Sep 2001 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRINTVN>; Fri, 14 Sep 2001 15:21:13 -0400
Received: from [209.202.108.240] ([209.202.108.240]:30473 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S267196AbRINTVA>; Fri, 14 Sep 2001 15:21:00 -0400
Date: Fri, 14 Sep 2001 15:21:05 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Strange /dev/loop behavior
In-Reply-To: <Pine.LNX.4.33.0109141505530.29038-100000@winds.org>
Message-ID: <Pine.LNX.4.33.0109141519490.5549-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Byron Stanoszek wrote:

> Is there any known method of copying/compressing the loopback-mounted file-
> system that always guarantees consistency after a sync, without requiring the
> fs to be unmounted first?

Try mounting the loop device synchronously (mount ... -o sync).

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


