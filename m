Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTHBNmv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHBNmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:42:51 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:42208 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S263737AbTHBNmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:42:50 -0400
Subject: Re: Linux 2.4.22-pre10-ac1
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Cox <alan@redhat.com>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308021229.h72CT5128965@devserv.devel.redhat.com>
References: <200308021229.h72CT5128965@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Aug 2003 15:42:27 +0200
Message-Id: <1059831754.22190.102.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > not quite true. If hotplug is not enabled it tells the driver that the
> > firmware can't be loaded. It is the same if hotplug_path is zero, or you
> 
> The ifdef should be there, or firmware should depend on hotplug, and
> probably the firmware users should also depend on hotplug

I definitively prefer the #ifdef, because the firmware loader should 
automaticly selected and compiled if a driver needs it. But let a driver
depend on hotplug can not be the solution, because some drivers maybe
also work if the firmware loading fails.

Regards

Marcel


