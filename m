Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTHBM3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTHBM3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:29:12 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:46077 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263407AbTHBM3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:29:11 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200308021229.h72CT5128965@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.22-pre10-ac1
To: marcel@holtmann.org (Marcel Holtmann)
Date: Sat, 2 Aug 2003 08:29:05 -0400 (EDT)
Cc: ranty@debian.org (Manuel Estrada Sainz),
       barryn@pobox.com (Barry K. Nathan), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1059818258.22190.43.camel@pegasus> from "Marcel Holtmann" at Aws 02, 2003 11:57:31 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> not quite true. If hotplug is not enabled it tells the driver that the
> firmware can't be loaded. It is the same if hotplug_path is zero, or you

The ifdef should be there, or firmware should depend on hotplug, and
probably the firmware users should also depend on hotplug

