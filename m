Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbUKXIl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbUKXIl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKXIl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:41:27 -0500
Received: from colino.net ([213.41.131.56]:65526 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262531AbUKXIl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:41:26 -0500
Date: Wed, 24 Nov 2004 09:40:52 +0100
From: Colin Leroy <colin@colino.net>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124094052.0f747c87@pirandello>
In-Reply-To: <20041124075038.GG2460@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<20041124031726.GF8040@waste.org>
	<20041124083430.5cf5d621@pirandello>
	<20041124075038.GG2460@waste.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs163.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2004 at 23h11, Matt Mackall wrote:

Hi, 

> Probably ought to go through Ogawa, if he can be convinced to take it.
> Please take a look at adding -o sync and -o async options to override
> the superblock flag first.

Isn't it this option that sets the superblock flag ? I didn't look at 
mount's source, but according from ext2 source and fs/namespace.c, 
this is it...

-- 
Colin
