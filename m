Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVAUEID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVAUEID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 23:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVAUEIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 23:08:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:31664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262263AbVAUEHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 23:07:37 -0500
Date: Thu, 20 Jan 2005 20:07:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: mpm@selenic.com, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-Id: <20050120200711.4313dbcc.akpm@osdl.org>
In-Reply-To: <20050120200530.4d5871f9.akpm@osdl.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
	<20050120160123.14f13ca6.akpm@osdl.org>
	<20050121035758.GH12076@waste.org>
	<20050120200530.4d5871f9.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Next suspects would be:
> 
>  +cleanup-vc-array-access.patch
>  +remove-console_macrosh.patch
>  +merge-vt_struct-into-vc_data.patch
> 
> 

Make that:

+cleanup-vc-array-access.patch
+remove-console_macrosh.patch
+merge-vt_struct-into-vc_data.patch
+vgacon-fixes-to-help-font-restauration-in-x11.patch

and the fbdev updates, maybe:

+radeonfb-set-accelerator-id.patch
+vesafb-change-return-error-id.patch
+intelfb-workaround-for-830m.patch
+fbcon-save-blank-state-last.patch
+backlight-fix-compile-error-if-config_fb-is-unset.patch
+matroxfb-fb_matrox_g-kconfig-changes.patch


