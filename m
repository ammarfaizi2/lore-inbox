Return-Path: <linux-kernel-owner+w=401wt.eu-S964875AbWLTE3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWLTE3I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWLTE3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:29:08 -0500
Received: from hera.kernel.org ([140.211.167.34]:56139 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875AbWLTE3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:29:06 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 0/2] more patches for removable drive bay
Date: Tue, 19 Dec 2006 23:28:32 -0500
User-Agent: KMail/1.9.5
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
In-Reply-To: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192328.32595.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for removing the new procfs code Kristen.

applied.
-Len

On Saturday 16 December 2006 17:40, Kristen Carlson Accardi wrote:
> Hi Len,
> Here's a set of patches for changing the removable drive bay driver
> (drivers/acpi/bay) from using the old proc interface to using a sysfs
> interface instead.  I made the bay driver a platform driver, and 
> so it's entries will now be located in /sys/devices/platform/bay.X.
> There are still 2 entries - one for checking whether the bay is
> present (present) that is read only, and one that is write only for
> ejecting the bay (eject).  Let me know if you would prefer me to fold
> these into the original bay driver patch.
> 
> Thanks,
> Kristen
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
