Return-Path: <linux-kernel-owner+w=401wt.eu-S1030494AbXAHTPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbXAHTPu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXAHTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:15:50 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:28383 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030494AbXAHTPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:15:49 -0500
Date: Mon, 8 Jan 2007 20:16:37 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 0/2] driver core: device_move() fallout.
Message-ID: <20070108201637.4a39c5d5@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here are two patches that hopefully make device_move() more universally
usable:

[1/2] Remove device_is_registered() in device_move().
[2/2] Allow device_move(dev, NULL).

Patches are against your latest git tree. The code works for me, but
has not been heavily tested.
