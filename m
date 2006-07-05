Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWGETFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWGETFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWGETFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:05:22 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:24478 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964927AbWGETFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:05:22 -0400
Subject: Re: [PATCH] release_firmware() fixes
From: Marcel Holtmann <marcel@holtmann.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060705062033.6692.14131.sendpatchset@cherry.local>
References: <20060705062033.6692.14131.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 21:05:04 +0200
Message-Id: <1152126304.4260.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magnus,

> Use release_firmware() to free requested resources.
> 
> According to Documentation/firmware_class/README the request_firmware() call
> should be followed by a release_firmware(). Some drivers do not however free
> the firmware previously allocated with request_firmware(). This patch tries to
> fix this by making sure that release_firmware() is used as expected.

thanks for catching these. I even overlooked one one in my own drivers.

> Signed-off-by: Magnus Damm <magnus@valinux.co.jp>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


