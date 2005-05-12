Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVELVyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVELVyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVELVyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:54:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:43414 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262146AbVELVyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:54:35 -0400
Date: Thu, 12 May 2005 14:54:39 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       sensors@stimpy.netroedge.com
Subject: Re: 2.6.12-rc4-mm1
Message-ID: <20050512215439.GA30324@kroah.com>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> -gregkh-01-driver-gregkh-driver-001_driver-hotplug_check.patch
> -gregkh-01-driver-gregkh-driver-002_debugfs_simple_newline.patch
> -gregkh-01-driver-gregkh-driver-009_driver-name-const-01.patch
> -gregkh-01-driver-gregkh-driver-010_driver-name-const-02.patch
> -gregkh-01-driver-gregkh-driver-011_driver-name-const-03.patch
> -gregkh-01-driver-gregkh-driver-012_driver-name-const-04.patch
> -gregkh-01-driver-gregkh-driver-013_driver-name-const-05.patch
> -gregkh-01-driver-gregkh-driver-014_driver-name-const-06.patch
> -gregkh-01-driver-gregkh-driver-015_sysfs-show_store_eio-01.patch
> -gregkh-01-driver-gregkh-driver-016_sysfs-show_store_eio-02.patch
> -gregkh-01-driver-gregkh-driver-017_sysfs-show_store_eio-03.patch
> -gregkh-01-driver-gregkh-driver-018_sysfs-show_store_eio-04.patch
> -gregkh-01-driver-gregkh-driver-019_sysfs-show_store_eio-05.patch
> -gregkh-01-driver-gregkh-driver-020_class-01-core.patch
> -gregkh-01-driver-gregkh-driver-021_class-02-tty.patch
> -gregkh-01-driver-gregkh-driver-022_class-03-input.patch
> -gregkh-01-driver-gregkh-driver-023_class-04-usb.patch
> -gregkh-01-driver-gregkh-driver-024_class-05-sound.patch
> -gregkh-01-driver-gregkh-driver-025_class-06-block.patch
> -gregkh-01-driver-gregkh-driver-026_class-07-char.patch
> -gregkh-01-driver-gregkh-driver-027_class-08-ieee1394.patch
> -gregkh-01-driver-gregkh-driver-028_class-09-scsi.patch
> -gregkh-01-driver-gregkh-driver-029_class-10-arch.patch
> -gregkh-01-driver-gregkh-driver-030_class-11-drivers.patch
> -gregkh-01-driver-gregkh-driver-031_class-11-drivers-usb-fix.patch
> -gregkh-01-driver-gregkh-driver-032_class-12-the_rest.patch
> -gregkh-01-driver-gregkh-driver-033_class-13-kerneldoc.patch
> -gregkh-01-driver-gregkh-driver-034_class-14-no_more_class_simple.patch
> -gregkh-01-driver-gregkh-driver-035_class-15-typo-01.patch
> -gregkh-01-driver-gregkh-driver-036_class-16-typo-02.patch
> -gregkh-01-driver-gregkh-driver-037_class-17-attribute.patch
> -gregkh-01-driver-gregkh-driver-038_klist-01.patch
> -gregkh-01-driver-gregkh-driver-039_klist-02.patch
> -gregkh-01-driver-gregkh-driver-040_klist-03.patch
> -gregkh-01-driver-gregkh-driver-041_klist-04.patch
> -gregkh-01-driver-gregkh-driver-042_klist-05.patch
> -gregkh-01-driver-gregkh-driver-043_klist-06.patch
> -gregkh-01-driver-gregkh-driver-044_klist-07.patch
> -gregkh-01-driver-gregkh-driver-045_klist-08.patch
> -gregkh-01-driver-gregkh-driver-046_klist-09.patch
> -gregkh-01-driver-gregkh-driver-047_klist-10.patch
> -gregkh-01-driver-gregkh-driver-048_klist-11.patch
> -gregkh-01-driver-gregkh-driver-049_klist-12.patch
> -gregkh-01-driver-gregkh-driver-050_klist-13.patch
> -gregkh-01-driver-gregkh-driver-051_klist-14.patch
> -gregkh-01-driver-gregkh-driver-052_klist-15.patch
> -gregkh-01-driver-gregkh-driver-053_klist-16.patch
> -gregkh-01-driver-gregkh-driver-054_klist-17.patch
> -gregkh-01-driver-gregkh-driver-055_klist-18.patch
> -gregkh-01-driver-gregkh-driver-056_klist-scsi-01.patch
> -gregkh-01-driver-gregkh-driver-057_klist-scsi-02.patch
> -gregkh-01-driver-gregkh-driver-058_klist-20.patch
> -gregkh-01-driver-gregkh-driver-059_klist-21.patch
> -gregkh-01-driver-gregkh-driver-060_klist-22.patch
> -gregkh-01-driver-gregkh-driver-061_klist-23.patch
> -gregkh-01-driver-gregkh-driver-062_klist-ieee1394.patch
> -gregkh-01-driver-gregkh-driver-063_klist-pcie.patch
> -gregkh-01-driver-gregkh-driver-064_klist-24.patch
> -gregkh-01-driver-gregkh-driver-065_klist-25.patch
> -gregkh-01-driver-gregkh-driver-066_klist-26.patch
> -gregkh-01-driver-gregkh-driver-067_klist-usb_node_attached_fix.patch
> -gregkh-01-driver-gregkh-driver-068_klist-sn_fix.patch
> +gregkh-01-driver-gregkh-driver-001_driver-pm-diag-update.patch
> +gregkh-01-driver-gregkh-driver-002_driver-name-const-01.patch
> +gregkh-01-driver-gregkh-driver-003_driver-name-const-02.patch
> +gregkh-01-driver-gregkh-driver-004_driver-name-const-03.patch
> +gregkh-01-driver-gregkh-driver-005_driver-name-const-04.patch
> +gregkh-01-driver-gregkh-driver-006_driver-name-const-05.patch
> +gregkh-01-driver-gregkh-driver-007_driver-name-const-06.patch
> +gregkh-01-driver-gregkh-driver-008_sysfs-show_store_eio-01.patch
> +gregkh-01-driver-gregkh-driver-009_sysfs-show_store_eio-02.patch
> +gregkh-01-driver-gregkh-driver-010_sysfs-show_store_eio-03.patch
> +gregkh-01-driver-gregkh-driver-011_sysfs-show_store_eio-04.patch
> +gregkh-01-driver-gregkh-driver-012_sysfs-show_store_eio-05.patch
> +gregkh-01-driver-gregkh-driver-013_class-01-core.patch
> +gregkh-01-driver-gregkh-driver-014_class-02-tty.patch
> +gregkh-01-driver-gregkh-driver-015_class-03-input.patch
> +gregkh-01-driver-gregkh-driver-016_class-04-usb.patch
> +gregkh-01-driver-gregkh-driver-017_class-05-sound.patch
> +gregkh-01-driver-gregkh-driver-018_class-06-block.patch
> +gregkh-01-driver-gregkh-driver-019_class-07-char.patch
> +gregkh-01-driver-gregkh-driver-020_class-08-ieee1394.patch
> +gregkh-01-driver-gregkh-driver-021_class-09-scsi.patch
> +gregkh-01-driver-gregkh-driver-022_class-10-arch.patch
> +gregkh-01-driver-gregkh-driver-023_class-11-drivers.patch
> +gregkh-01-driver-gregkh-driver-024_class-11-drivers-usb-fix.patch
> +gregkh-01-driver-gregkh-driver-025_class-12-the_rest.patch
> +gregkh-01-driver-gregkh-driver-026_class-13-kerneldoc.patch
> +gregkh-01-driver-gregkh-driver-027_class-14-no_more_class_simple.patch
> +gregkh-01-driver-gregkh-driver-028_fix-make-mandocs-after-class_simple-removal.patch
> +gregkh-01-driver-gregkh-driver-029_klist-01.patch
> +gregkh-01-driver-gregkh-driver-030_klist-02.patch
> +gregkh-01-driver-gregkh-driver-031_klist-03.patch
> +gregkh-01-driver-gregkh-driver-032_klist-04.patch
> +gregkh-01-driver-gregkh-driver-033_klist-05.patch
> +gregkh-01-driver-gregkh-driver-034_klist-06.patch
> +gregkh-01-driver-gregkh-driver-035_klist-07.patch
> +gregkh-01-driver-gregkh-driver-036_klist-08.patch
> +gregkh-01-driver-gregkh-driver-037_klist-09.patch
> +gregkh-01-driver-gregkh-driver-038_klist-10.patch
> +gregkh-01-driver-gregkh-driver-039_klist-11.patch
> +gregkh-01-driver-gregkh-driver-040_klist-12.patch
> +gregkh-01-driver-gregkh-driver-041_klist-13.patch
> +gregkh-01-driver-gregkh-driver-042_klist-14.patch
> +gregkh-01-driver-gregkh-driver-043_klist-15.patch
> +gregkh-01-driver-gregkh-driver-044_klist-16.patch
> +gregkh-01-driver-gregkh-driver-045_klist-17.patch
> +gregkh-01-driver-gregkh-driver-046_klist-18.patch
> +gregkh-01-driver-gregkh-driver-047_klist-scsi-01.patch
> +gregkh-01-driver-gregkh-driver-048_klist-scsi-02.patch
> +gregkh-01-driver-gregkh-driver-049_klist-20.patch
> +gregkh-01-driver-gregkh-driver-050_klist-21.patch
> +gregkh-01-driver-gregkh-driver-051_klist-22.patch
> +gregkh-01-driver-gregkh-driver-052_klist-23.patch
> +gregkh-01-driver-gregkh-driver-053_klist-ieee1394.patch
> +gregkh-01-driver-gregkh-driver-054_klist-pcie.patch
> +gregkh-01-driver-gregkh-driver-055_klist-24.patch
> +gregkh-01-driver-gregkh-driver-056_klist-25.patch
> +gregkh-01-driver-gregkh-driver-057_klist-26.patch
> +gregkh-01-driver-gregkh-driver-058_klist-usb_node_attached_fix.patch
> +gregkh-01-driver-gregkh-driver-059_klist-sn_fix.patch
> +gregkh-01-driver-gregkh-driver-060_klist-driver_detach_fixes.patch
> +gregkh-01-driver-gregkh-driver-061_klist-usbcore-dont_call_device_release_driver_recursivly.patch
> +gregkh-01-driver-gregkh-driver-062_driver-create-unregister_node.patch
> +gregkh-01-driver-gregkh-driver-063_attr_void.patch
> 
>  Greg keeps renaming stuff.

Ok, I can take the hint :)

I've changed my script to not add a number to the patch in order to
convey what the order in which the patches are applied in.  Now I keep
the patch name the same as it originally was (and the timestamp for
those who use rsync to see if anything has changed.)  I've added a
series file for each directory to show the order to apply them in.

This should help reduce the churn you report here, and help others who
try to keep track of what I have and have not applied.

Please let me know if this doesn't work out.

thanks,

greg k-h
