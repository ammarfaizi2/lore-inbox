Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTFQOvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbTFQOss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:48:48 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:45297 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S264801AbTFQOsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:48:16 -0400
Date: Tue, 17 Jun 2003 17:02:05 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Igor Krasnoselski <iek@tut.by>
cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Can't mount an ext3 partition - why?
In-Reply-To: <11725.030617@tut.by>
Message-ID: <Pine.LNX.4.44.0306171657190.31266-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, Igor Krasnoselski wrote:

> e2fsck gets them as previous /dev/hd+ args and reports no errors.
> Is this a new feature since 2.4.18-3 kernel? Or maybe this all because
> I add something strange to my config, like "/dev filesystem" ?

And CONFIG_DEVFS_MOUNT=y , right? Install devfsd, or modify fstab, or use
the devfs=nomount boot parameter.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

