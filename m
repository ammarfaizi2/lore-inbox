Return-Path: <linux-kernel-owner+w=401wt.eu-S932492AbXAIW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbXAIW6g (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbXAIW6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:58:36 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:43988 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbXAIW6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:58:35 -0500
Subject: Re: [Patch 0/2] driver core: device_move() fallout.
From: Marcel Holtmann <marcel@holtmann.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20070108201637.4a39c5d5@gondolin.boeblingen.de.ibm.com>
References: <20070108201637.4a39c5d5@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 23:58:13 +0100
Message-Id: <1168383493.7216.1.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> here are two patches that hopefully make device_move() more universally
> usable:
> 
> [1/2] Remove device_is_registered() in device_move().
> [2/2] Allow device_move(dev, NULL).
> 
> Patches are against your latest git tree. The code works for me, but
> has not been heavily tested.

I tested it with my patch for the Bluetooth RFCOMM layer and it works
fine. Please make sure that it gets into 2.6.20 as soon as possible,
because the current device_move() is simply broken.

Regards

Marcel


