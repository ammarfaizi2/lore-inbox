Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUKIX2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUKIX2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKIX23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:28:29 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:65166 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261771AbUKIX2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:28:17 -0500
Date: Wed, 10 Nov 2004 00:25:10 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: seby@focomunicatii.ro
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, alan@redhat.com,
       jgarzik@pobox.com
Subject: Re: ZyXEL GN650-T
Message-ID: <20041109232510.GA5582@electric-eye.fr.zoreil.com>
References: <20041107214427.20301.qmail@focomunicatii.ro> <20041107224803.GA29248@electric-eye.fr.zoreil.com> <20041109000006.GA14911@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109000006.GA14911@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
> seby@focomunicatii.ro <seby@focomunicatii.ro> :
> [...]
> > I just bouth a zyxel GN650T network card .. and it sems that vlan's don't 
> > work on this card .. anybody had this problems with this card .. 
> 
> Patch below against 2.6.10-rc1-bk15 + Jeff's netdev should convert the driver
> to the in-kernel vlan API.

Cr*p, the driver had not been backported to 2.4.x. Ok, instant patch (155 ko)
against 2.4.28-rc2 available at:
http://www.fr.zoreil.com/people/francois/misc/20041110-2.4.28-rc2-via-velocity-backport.patch

--
Ueimor
