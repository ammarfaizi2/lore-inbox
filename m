Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVE3RVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVE3RVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVE3RVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:21:19 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:36299 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261652AbVE3RVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:21:15 -0400
Date: Mon, 30 May 2005 13:21:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Clemente Aguiar <caguiar@madeiratecnopolo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC-79xx HostRaid
Message-ID: <20050530172105.GA15253@havoc.gtf.org>
References: <6A0C419392D7BA45BD141D0BA4F253C776F1@loureiro.madeiratecnopolo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A0C419392D7BA45BD141D0BA4F253C776F1@loureiro.madeiratecnopolo.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 06:13:03PM +0100, Clemente Aguiar wrote:
> 
> Hello,
> 
> We have acquired some IBM xServers which have an integrated raid controller
> based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
> 
> Is there already support for HostRaid? Are there drivers for it?
> >From which kernel version and where do I find it in the config?

HostRaid is just software RAID; you can ignore it and let Linux use the
underlying SCSI devices via the standard aic79xx driver.

	Jeff



