Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280828AbRKGQGK>; Wed, 7 Nov 2001 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280830AbRKGQGA>; Wed, 7 Nov 2001 11:06:00 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:49989 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280828AbRKGQFz>; Wed, 7 Nov 2001 11:05:55 -0500
Message-ID: <3BE95BD4.D652152A@mandrakesoft.com>
Date: Wed, 07 Nov 2001 11:05:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: quintela@mandrakesoft.com, sbenedict@mandrakesoft.com
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: alpha and PPC broken by latest kernel RPM
In-Reply-To: <3BE95AB4.96C1D729@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Of the following options, only -one- actually exists on alpha,
> DEBUG_SLAB:

Correction, DEBUG_SLAB only exists in my private tree ;-)  That entire
section should be covered with %ifarch %ix86.

+ grep -q DEBUG_SLAB arch/alpha/defconfig
+ echo 'no DEBUG_SLAB feature'
no DEBUG_SLAB feature
+ return 1
error: Bad exit status from /tmp/rpm/tmp/rpm-tmp.94164 (%build)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

