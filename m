Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWELGmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWELGmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWELGmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:42:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750999AbWELGmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:42:50 -0400
Date: Thu, 11 May 2006 23:39:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.17-rc4
Message-Id: <20060511233955.0e8454fa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok, I've let the release time between -rc's slide a bit too much again, 
>  but -rc4 is out there, and this is the time to hunker down for 2.6.17.

I have rather a lot of stuff still queued:

selinux-check-for-failed-kmalloc-in-security_sid_to_context.patch
fs-openc-unexport-sys_openat.patch
autofs4-nfy_none-wait-race-fix.patch
autofs4-nfy_none-wait-race-fix-tidy.patch
fix-capi-reload-by-unregistering-the-correct-major.patch
tpm-update-module-dependencies.patch
pcmcia-oopses-fixes.patch
via-quirk-fixup-additional-pci-ids.patch
rcu-introduce-rcu_needs_cpu-interface.patch
rcu-introduce-rcu_needs_cpu-interface-fix.patch
s390-exploit-rcu_needs_cpu-interface.patch
setup_per_zone_pages_min-overflow-fix.patch
s390-lcs-incorrect-test.patch
initramfs-fix-cpio-hardlink-check.patch
s390-add-vmsplice-system-call.patch
symbol_put_addr-locks-kernel.patch
contact-info-update.patch
smbfs-fix-slab-corruption-in-samba-error-path.patch
add-slab_is_available-routine-for-boot-code.patch
x86_64-disable-aperture-pci-region-check-in-amd64.patch
x86_64-check-for-too-many-northbridges-in-iommu.patch
led-improve-kconfig-information.patch
backlight-lcd-class-fix-sysfs-_store-error-handling.patch
led-add-maintainer-entry-for-the-led-subsystem.patch
led-fix-sysfs-store-function-error-handling.patch
v9fs-twalk-memory-leak.patch
v9fs-signal-handling-fixes.patch
fix-can_share_swap_page-when-config_swap.patch
add-core-solo-and-core-duo-support-to-oprofile.patch
tpm-fix-constant.patch
final-rio-polish.patch
tpm_register_hardware-gcc-41-warning-fix.patch
fs-compatc-fix-if-a-=-b-typo.patch
root-mount-failure-emit-filesystems-attempted.patch

Some of which I still need originator confirmation from.  Maybe tomorrow,
more likely the day after..
