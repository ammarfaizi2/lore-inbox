Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTHZRSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbTHZRSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:18:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10254
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262681AbTHZRR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:17:59 -0400
Date: Tue, 26 Aug 2003 10:17:54 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bk patches] net driver updates
Message-ID: <20030826171754.GD16831@matchmail.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20030817183137.GA18521@gtf.org> <20030823154231.A11381@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823154231.A11381@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 03:42:31PM +0200, Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [net-drivers-2.6 update]
> >  drivers/net/sis190.c              | 2094 +++++++++++++++++++++++++++++---------
> 
> 
> synchronize_irq() requires an argument when built with CONFIG_SMP.

Shouldn't it also require it for the UP case?  Or is this one of those
subtle things that tells you it's not working on SMP?
