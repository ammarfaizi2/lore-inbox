Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVI1Wrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVI1Wrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVI1Wrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:47:45 -0400
Received: from alpha.polcom.net ([217.79.151.115]:47280 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750951AbVI1Wro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:47:44 -0400
Date: Thu, 29 Sep 2005 00:48:36 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
In-Reply-To: <433B16BD.7040409@gentoo.org>
Message-ID: <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
References: <43146CC3.4010005@gentoo.org>  <58cb370e05083008121f2eb783@mail.gmail.com>
  <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
 <433B16BD.7040409@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Daniel Drake wrote:

> This entry adds needless complication to the driver as it requires the use of
> global variables to be passed into via_get_info(), making things quite ugly
> when we try and make this driver support multiple controllers simultaneously.
>
> This patch removes /proc/via for simplicity.

Is similar data available from sysfs?

As a user of this controller, I think that if it is not then this patch 
should be changed to export it or should be dropped. The data from that 
file is really helpfull in debugging problems (for example related to bad 
cables or breaking disks/cdroms).


Thanks,

Grzegorz Kulewski
