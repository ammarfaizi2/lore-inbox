Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163548AbWLGWrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163548AbWLGWrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163547AbWLGWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:47:23 -0500
Received: from hera.kernel.org ([140.211.167.34]:57750 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163470AbWLGWrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:47:22 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 0/3] Dock patches
Date: Thu, 7 Dec 2006 17:50:23 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20061204144930.ee923959.kristen.c.accardi@intel.com>
In-Reply-To: <20061204144930.ee923959.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071750.24523.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 17:49, Kristen Carlson Accardi wrote:
> Hi Len,
> Here are a set of patches for the dock station driver (drivers/acpi/dock).
> One makes the dock station driver also a platform driver.  The second
> adds sysfs entries which will be created under /sys/devices/platform/dock.0
> to allow the user to read the status of the dock station (1 for docked, 0
> undocked) and to initiate an undock request via software by writing to
> the "undock" entry.  The third patch fixes a bug that would prevent
> acpiphp from loading if the dock station was not able to load (on systems
> with no _DCK in the dsdt).

1,2,3 applied.

thanks,
-Len
