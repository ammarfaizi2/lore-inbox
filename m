Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWELSav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWELSav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWELSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:30:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751223AbWELSau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:30:50 -0400
Date: Fri, 12 May 2006 11:27:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, trenn@suse.de, thoenig@suse.de,
       c-d.hailfinger.devel.2006@gmx.net
Subject: Re: [patch] smbus unhiding kills thermal management
Message-Id: <20060512112742.5ab21993.akpm@osdl.org>
In-Reply-To: <20060512095343.GA28375@elf.ucw.cz>
References: <20060512095343.GA28375@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Do not enable the SMBus device on Asus boards if suspend
>  is used. We do not reenable the device on resume, leading to all sorts
>  of undesirable effects, the worst being a total fan failure after
>  resume on Samsung P35 laptop.
> 
>  Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
>  Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
>  ---
>  commit f14c852a8cb7483ce0e1e0e05ef49fed2f67103b
>  tree ab0cbe41b344a62bc81dd5cb093e3b6062c12556
>  parent 392dbe84f1e484b1e48036ca266cb826fd34f8da
>  author <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200
>  committer <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200

Are these attributions correct, or did Carl-Daniel write it?
