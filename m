Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVLLJjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVLLJjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVLLJjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:39:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbVLLJjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:39:08 -0500
Date: Mon, 12 Dec 2005 01:38:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Seyfried <seife@suse.de>
Cc: vojtech@suse.cz, dtor_core@ameritech.net, luming.yu@intel.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       bero@arklinux.org
Subject: Re: [git pull 02/14] Add Wistron driver
Message-Id: <20051212013844.59a1f76e.akpm@osdl.org>
In-Reply-To: <20051212091427.GB21522@suse.de>
References: <20051211224059.GA28388@midnight.suse.cz>
	<20051212001315.0e2c64f1.akpm@osdl.org>
	<20051212091427.GB21522@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried <seife@suse.de> wrote:
>
> On Mon, Dec 12, 2005 at 12:13:15AM -0800, Andrew Morton wrote:
> > Stefan Seyfried <seife@suse.de> wrote:
> 
> > > pcc_acpi already does this successfully and is a pleasure to use.
> > 
> > That's not in the tree any more.   Did something replace it?
> 
> No. The ACPI Mafia^H^H^Hintainers :-) no longer accept any hotkey drivers
> and IIUC it will be reimplemented in a generic driver. This driver
> then should pipe the hotkey events to the input subsystem.

hm.  It seems a fairly bad idea to remove functionality before that
functionality has been implemented by the other means and has been rolled
out by distros for some time.
