Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264188AbUFBVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUFBVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUFBVSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:18:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26754 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264175AbUFBVRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:17:50 -0400
Date: Wed, 2 Jun 2004 17:16:46 -0400
From: Alan Cox <alan@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
Message-ID: <20040602211646.GA9419@devserv.devel.redhat.com>
References: <20040602201315.GA10339@devserv.devel.redhat.com> <40BE3F00.4090408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE3F00.4090408@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 04:56:32PM -0400, Jeff Garzik wrote:
> >+ *	rx_copybreak/alignment
> >+ *	Scatter gather
> >+ *	More testing
> 
> I would prefer not to merge to mainline until big endian is working... 
> certainly it can still receive wide testing in Andrew's -mm tree.

Most of our drivers don't work bigendian. If you want it bigendian you
can find someone to do it because I don't have the hardware to verify
bigendian and currently there probably isnt a single big endian user of this
chip on the planet.

It may well work big endian, but someone will have to hand glue a sparc to
a via chipset and add on ethernet to find out 8)

