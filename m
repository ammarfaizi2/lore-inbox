Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUANSaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUANS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:28:44 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:58884 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263370AbUANS2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:28:39 -0500
Date: Wed, 14 Jan 2004 19:30:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <20040114193040.6606813f.khali@linux-fr.org>
In-Reply-To: <20040112014840.GE17845@matchmail.com>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
	<20040112014840.GE17845@matchmail.com>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about some patches to add some more sensors to the 2.4 kernel,
> like the ones already in 2.6?

The 2.4 kernel has reached a maintainance-only point so there is no way
lm_sensors could be officially merged into it now, especially since the
i2c layer itself would have to be significantly reworked before.

So your options are either to patch your 2.4 tree using the i2c patch
and additional drivers we provide, or to jump to Linux 2.6.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
