Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWA2TGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWA2TGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWA2TGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:06:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4810 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751116AbWA2TGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:06:14 -0500
Date: Sun, 29 Jan 2006 11:06:24 -0800
From: Greg KH <greg@kroah.com>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_KOBJECT_UEVENTS in 2.6.15
Message-ID: <20060129190624.GB26794@kroah.com>
References: <43DCB687.1090605@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DCB687.1090605@poczta.fm>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 01:35:19PM +0100, Lukasz Stelmach wrote:
> Greetings.
> 
> IMHO since CONFIG_KOBJECT_UEVENT depends on CONFIG_EMBEDDED it should be
> placed in this menu. Now it is in "General setup", what might cause, or
> I am such a dumb, some confusion because it is invisible "without any
> reason" until C_E is. Here you are a patch that, let me say, fixes the
> Kconfig file.

KOBJECT_UEVENT is gone from 2.6.16-rc, so this patch isn't needed at
all.

thanks,

greg k-h
