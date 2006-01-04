Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWADHNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWADHNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWADHNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:13:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbWADHNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:13:41 -0500
Date: Tue, 3 Jan 2006 23:13:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-Id: <20060103231304.56e3228b.akpm@osdl.org>
In-Reply-To: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
>  Add MSI(X) configure space save/restore in generic PCI helper.

This adds a bunch of code which isn't needed if !CONFIG_PM.
