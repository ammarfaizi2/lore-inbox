Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317847AbSGZQmd>; Fri, 26 Jul 2002 12:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSGZQmc>; Fri, 26 Jul 2002 12:42:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38857 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317844AbSGZQmb>;
	Fri, 26 Jul 2002 12:42:31 -0400
Date: Fri, 26 Jul 2002 12:45:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kurt Garloff <garloff@suse.de>
cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (1/5)
In-Reply-To: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl>
Message-ID: <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Jul 2002, Kurt Garloff wrote:

> Hi,
> 
> here comes patch 1/5 from a series of patches to support more than 128 (and
> optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driver
> to dynamically allocate memory and register block majors as disks get
> attached.
> 
> The patches are all available at
> http://www.suse.de/~garloff/linux/scsi-many/

As long as you realize that it won't go in 2.5 in that form...

