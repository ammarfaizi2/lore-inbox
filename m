Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbTDRIyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTDRIyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:54:41 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59558 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262972AbTDRIyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:54:40 -0400
Date: Fri, 18 Apr 2003 09:06:35 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030418090635.A16232@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com> <3E9F3D6F.9030501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9F3D6F.9030501@pobox.com>; from jgarzik@pobox.com on Thu, Apr 17, 2003 at 07:49:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 07:49:03PM -0400, Jeff Garzik wrote:
> Three tangents:
> 1) where did the 486 string ops go?

those were slower even on 80486, and broken as well

> 2) why no sse2-optimized memcpy?  just that noone has done one yet?

I've not moved the userspace prototype to kernelspace

