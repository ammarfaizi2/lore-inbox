Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUIOIQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUIOIQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUIOIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:16:46 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:52495 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S263117AbUIOIQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:16:45 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Date: Wed, 15 Sep 2004 10:19:50 +0200
User-Agent: KMail/1.6.2
References: <20040911165300.GA17028@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net>
In-Reply-To: <4147E525.4000405@ppp0.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409151019.50592.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 of September 2004 08:45, Jan Dittmer wrote:
> What's wrong about fixing acpi to have something like
> /sys/devices/acpi/buttons/power/, that spits out the event?
> Just curious...

Well, the fact that you'd have to somehow:
1) pass the list of all the drivers that register notify handlers to the 
userspace
2) make userspace daemons hold ~10 sysfs nodes open

Not that it's not feasible, but that's simply ugly IMHO.
Best regards,

-- 
Karol Kozimor
kkozimor@aurox.org
