Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWAaSVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWAaSVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWAaSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:21:33 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:62020 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751318AbWAaSVc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:21:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KxN0KRRSyCTQ/GZ2Wy8T4ap5I7TDa4ePkf/98GvqIKUJI5+9VduE6Z1JGDCXxngD72SgYLNwKhirxDReYvuChGqo6Wo1F0hcpuvCsYts65TyUiKX1ofe5Xpwy2UgtOxcFE4L3Wh6Kg9zIzcAOAbU8VcENUe+VtLK2+n7L4WD3wc=
Message-ID: <5bfe43f80601311021p2d84329fx13028daa63e2c2c8@mail.gmail.com>
Date: Tue, 31 Jan 2006 10:21:29 -0800
From: Charles Spirakis <bezaur@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: w83791d sensor support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All --

I noticed the w83791d chip is supported in 2.9.2 of lm_sensors (in
.../chips/w83781d.c) but that it isn't supported in the 2.6 kernel
(.../drivers/hw_mon/w83781d.c).

Does anyone know why? From what I can see in the lm_sensor's archive,
the support was added to lm_sensors around may of 2003.

Is there any interest in having support for the w83791d in the kernel driver?

-- charles
