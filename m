Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWDMX36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWDMX36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWDMX36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:29:58 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:36045 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S965044AbWDMX35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:29:57 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 13/22] edac_752x needs CONFIG_HOTPLUG
Date: Thu, 13 Apr 2006 16:25:09 -0700
User-Agent: KMail/1.5.3
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
References: <20060413230141.330705000@quad.kroah.org> <20060413230835.GN5613@kroah.com>
In-Reply-To: <20060413230835.GN5613@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131625.09829.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 16:08, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
>
> ------------------
>
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> EDAC_752X uses pci_scan_single_device(), which is only available
> if CONFIG_HOTPLUG is enabled, so limit this driver with HOTPLUG.
>
> This patch was already included in Linus' tree.
>
> Adrian Bunk:
> Rediffed for 2.6.16.x due to unrelated context changes.
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: David S. Peterson <dsp@llnl.gov>
