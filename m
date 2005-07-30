Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVG3OZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVG3OZG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVG3OZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:25:05 -0400
Received: from isilmar.linta.de ([213.239.214.66]:39591 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262962AbVG3OZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:25:03 -0400
Date: Sat, 30 Jul 2005 16:25:02 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: pavel@ucw.cz, mochel@digitalimplant.org
Cc: linux-kernel@vger.kernel.org
Subject: dpm_runtime_suspend and _resume()
Message-ID: <20050730142502.GA4065@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	pavel@ucw.cz, mochel@digitalimplant.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dpm_runtime_suspend and _resume() would be quite useful for some PCMCIA
tasks. However, they are only exported in drivers/base/power/power.h. Any
objection to moving it to include/linux/pm.h ? Any plans to break the
functionality these functions provide?

Thanks,
	Dominik
