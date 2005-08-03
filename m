Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVHCXXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVHCXXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVHCXXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:23:48 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:24000 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261638AbVHCXWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:22:35 -0400
X-Speedbone-MailScanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-MailScanner: 1.25st (Clear:RC:1(84.171.135.200):. Processed in 0.018219 secs Process 32620)
Date: Thu, 4 Aug 2005 01:22:36 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050803232236.GA13520@core.home>
References: <200508031559.24704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 03:59:24PM +1000, Con Kolivas wrote:
> Patch for 2.6.13-rc5

Just a few numbers:

I tried it on a Laptop (Dell C810, P3m 1133 mhz) and measured the power
usage with an external device and it stayed with or without patch at
27W. (HZ was at about 28)

On a desktop with AthlonXP with STOP activated i got a power usage of
57W with and without patch (without STOP activated 94W).
(HZ was about at 50)


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
