Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWDYD4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWDYD4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWDYD4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:56:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:6797 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751230AbWDYD4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:56:42 -0400
Date: Mon, 24 Apr 2006 20:55:29 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 3/4] dynamic configurable kref debugging
Message-ID: <20060425035529.GD18085@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083342.448143000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083342.448143000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:33:36PM +0800, Akinobu Mita wrote:
> This patch makes kref-debugging dynamically configurable
> by sysctl kernel.kref_debug

No new sysctls please, if anything, make this a sysfs file instead.

But even then, this should be a build option, not something you enable
at runtime.

thanks,

greg k-h
