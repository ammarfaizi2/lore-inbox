Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVAZIgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVAZIgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVAZIgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:36:46 -0500
Received: from koolhaas.vianetworks.nl ([212.61.66.38]:7172 "EHLO
	Rumba.Morgana.NET") by vger.kernel.org with ESMTP id S262387AbVAZIgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:36:45 -0500
Subject: Re: Drive missing only with LVM kernel
From: Jasper Koolhaas <jasper@Morgana.NET>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1106685009.8968.15.camel@localhost>
References: <1106685009.8968.15.camel@localhost>
Content-Type: text/plain
Organization: Morgana
Date: Wed, 26 Jan 2005 09:34:59 +0100
Message-Id: <1106728499.3646.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 21:30 +0100, Jasper Koolhaas wrote:

> As soon as the system had booted hdg has completely vanished, even in
> single user mode:
> 
> # ls /dev/hd* /dev/sd*
> /dev/hda   /dev/hda3  /dev/hdc1  /dev/hde   /dev/hde3  /dev/sda2  /dev/sdb1
> /dev/hda1  /dev/hda4  /dev/hdc2  /dev/hde1  /dev/sda   /dev/sda3  /dev/sdb2
> /dev/hda2  /dev/hdc   /dev/hdc3  /dev/hde2  /dev/sda1  /dev/sdb   /dev/sdb3

Oh, and I'm using a devfs so "cd /dev && ./MAKEDEV hdg" is not the
solution I think.

The odd thing is that without LVM compiled in the kernel or as
module /dev/hdg is accessible through devfs and with LVM not.

Kind regards, Jasper.


