Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUDUQIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUDUQIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDUQIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:08:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:34253 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263355AbUDUQGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:06:31 -0400
Date: Wed, 21 Apr 2004 17:05:37 +0100
From: Dave Jones <davej@redhat.com>
To: Charles Coffing <ccoffing@novell.com>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] unbalanced try_get_module/put_module in cpufreq
Message-ID: <20040421160537.GA18114@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Charles Coffing <ccoffing@novell.com>, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@brodo.de>
References: <200404211047.02906.ccoffing@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404211047.02906.ccoffing@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 10:47:02AM -0600, Charles Coffing wrote:
 > Hi,
 > 
 > This patch is against 2.6.5.  There's a small bug in cpufreq_add_dev:  If kmalloc fails, try_get_module() is not balanced by a module_put().
 > 

Thanks, applied. (Slightly different variant, but same end result).

		Dave

