Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTJXS3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJXS3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:29:54 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:65466 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262444AbTJXS3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:29:53 -0400
Date: Fri, 24 Oct 2003 14:29:51 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
In-Reply-To: <1067015103.5255.1.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.56.0310241426240.16668@marabou.research.att.com>
References: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan> 
 <20031024155343.GP5017@actcom.co.il>  <Pine.LNX.4.56.0310241234010.1701@marabou.research.att.com>
 <1067015103.5255.1.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003, Arjan van de Ven wrote:

> On Fri, 2003-10-24 at 18:50, Pavel Roskin wrote:
> \
> > It's missing on Red Hat Linux.
>
> It's not missing. For 2.4 kernels you don't need it to build external
> modules against. For the 2.6 kernel rpms
> (http://people.redhat.com/arjanv/2.5/ </shamelessplug>) the config is
> there as required

That's an interesting approach.  Well, if other distribution follow the
suit and include the /lib/modules/`uname -r`/build directory with the
packages, maybe compiling standalone drivers against precompiled kernels
won't be such a challenge as it is now.

Thank you for you reply.  Please disregard my patch.

-- 
Regards,
Pavel Roskin
