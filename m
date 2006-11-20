Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966426AbWKTWme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966426AbWKTWme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966637AbWKTWme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:42:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49089 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966591AbWKTWmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:42:33 -0500
Subject: Re: [Patch -mm 1/1] driver core: Introduce device_move(): move a
	device to a new parent.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20061120170751.6026e8f4@gondolin.boeblingen.de.ibm.com>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
	 <1163695657.7900.9.camel@min.off.vrfy.org>
	 <20061117042338.GA11131@kroah.com>
	 <20061120090537.6d59dbc5@gondolin.boeblingen.de.ibm.com>
	 <20061120135515.38298bf5@gondolin.boeblingen.de.ibm.com>
	 <1164032103.5541.12.camel@min.off.vrfy.org>
	 <20061120163946.38c878d7@gondolin.boeblingen.de.ibm.com>
	 <20061120170751.6026e8f4@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 23:42:30 +0100
Message-Id: <1164062550.4433.2.camel@min.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 17:07 +0100, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Provide a function device_move() to move a device to a new parent device. Add
> auxilliary functions kobject_move() and sysfs_move_dir().
> kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> interface kobject_uevent_env() is created that allows to add further
> environmental data to the uevent at the kobject layer.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Looks fine. Thanks a lot for doing the changes.

Kay

