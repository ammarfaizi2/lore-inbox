Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTLDMVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 07:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLDMVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 07:21:50 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:46728
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261670AbTLDMVt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 07:21:49 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko@croadria.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-ck1
Date: Thu, 4 Dec 2003 23:21:44 +1100
User-Agent: KMail/1.5.3
References: <200312040228.44980.kernel@kolivas.org> <200312041143.43629.tvrtko@croadria.com>
In-Reply-To: <200312041143.43629.tvrtko@croadria.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312042321.44902.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 21:43, Tvrtko A. Uršulin wrote:
> On Wednesday 03 December 2003 16:28, Con Kolivas wrote:
> > Updated my patchset.
>
> There is something wrong with /proc/stat which confuses xosview and
> ksysguard regarding CPU usage. Top is working ok.
>
> tvrtko@oxygene:~> cat /proc/stat
> cpu  7452 0 2048 40426
> cpu0 7452 0 2048 1844674407370950652

You're right. This looks like a hangover from the 64bit jiffies or the 
variable Hz. It's not a critical bug so unless someone can debug it for me it 
can wait.

Con

