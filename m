Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTKXLHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 06:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTKXLHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 06:07:49 -0500
Received: from [194.118.56.16] ([194.118.56.16]:58809 "EHLO mia.0xff.at")
	by vger.kernel.org with ESMTP id S263792AbTKXLHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 06:07:48 -0500
Subject: Re: New model of SanDisk compact flash not working
From: Karl Pitrich <pit@root.at>
To: gmlinux <gmlinux@x-plor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0887314A0D67E14C8C255BEF09FC3D99501157@x-plor-mail.jhb-xplor>
References: <0887314A0D67E14C8C255BEF09FC3D99501157@x-plor-mail.jhb-xplor>
Content-Type: text/plain
Message-Id: <1069672084.2366.140.camel@warp.fabafsc.fabagl.fabasoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 12:08:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 09:32, gmlinux wrote:

> I also get the following boot messages, which were not present on the
> old model:
> hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: task_no_data_intr: error=0x04 { DriveStatusError }

try building a kernel with CONFIG_IDEDISK_MULTI_MODE 
and use 'hda=noprobe' on the kernel command line.

 / karl

