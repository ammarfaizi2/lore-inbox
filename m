Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271659AbRHUNdG>; Tue, 21 Aug 2001 09:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271660AbRHUNc6>; Tue, 21 Aug 2001 09:32:58 -0400
Received: from jl1.quim.ucm.es ([147.96.5.12]:5892 "HELO jl1.quim.ucm.es")
	by vger.kernel.org with SMTP id <S271659AbRHUNcw>;
	Tue, 21 Aug 2001 09:32:52 -0400
Date: Tue, 21 Aug 2001 15:32:42 +0200
From: "Ram'on Garc'ia Fern'andez" <ramon@jl1.quim.ucm.es>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Kernel Crash 2.4.8
Message-ID: <20010821153242.A2049@jl1.quim.ucm.es>
In-Reply-To: <20010821140045.A1710@jl1.quim.ucm.es> <20010821141253.G672@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010821141253.G672@suse.de>; from axboe@suse.de on Tue, Aug 21, 2001 at 02:12:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 02:12:53PM +0200, Jens Axboe wrote:

> > EIP: C0186B6A (account_io_start + 0x26)
[...]
> 
> What else did you patch into this kernel? The above looks like it came
> from the sard patches, not part of the stock tree.

I acknowledge that there might be bugs caused by non standard patches,
but I think that this is unlikely.

This kernel comes from the Mandrake distribution, development version.

ftp.sunet.se:/pub/Linux/distributions/mandrake-devel/cooker/i586/Mandrake/RPMS/
              kernel-smp-2.4.8-7mdk.i586.rpm

Includes these patches (I tried to omit irrelevant patches) :

linux-2.4.1-ac3-upgrade-swap-limit.patch.bz2
linux-2.4.2-ac20-FXSR_686.patch.bz2
linux-2.4.2-ac20-TIOCGDEV.patch.bz2
linux-2.4.2-ac20-brokenmptable.patch.bz2
linux-2.4.2-ac20-multipath-export.patch.bz2
linux-2.4.2-ac20-pge.patch.bz2
linux-2.4.2-ac20-rd-progress.patch.bz2
linux-2.4.2-ac20-scsi-reset.patch.bz2
linux-2.4.2-ac20-setup_delay.patch.bz2
linux-2.4.3-ac12-nfsexp.patch.bz2
linux-2.4.3-ac3-gz-module.patch.bz2
linux-2.4.3-ac4-scsi_scan.patch.bz2
linux-2.4.5-ac19-overflow.patch.bz2
linux-2.4.6-ac1-multipath-fixes-2.patch.bz2
linux-2.4.6-ac1-multipath-md_error-fix.patch.bz2
linux-2.4.7-ac1-ide-floppy.patch.bz2
linux-2.4.7-ac1-scsimon-2.4.3-1.patch.bz2
linux-2.4.7-ac4-buffermem_pages-exported.patch.bz2
linux-2.4.8-ac1-ac3-passthrough.patch.bz2
linux-2.4.8-ac1-speedtouch-fixes.patch.bz2
linux-2.4.8-ac3-apic-quiet.patch.bz2
linux-2.4.8-ac3-iscsi.patch.bz2
linux-2.4.8-ac7-ioqueue.patch.bz2
patch-2.4.8-ac7.bz2


Irrelevant patches omitted above are:

3rdparty-bcm5700-1.4.5-gcc-fixes.patch.bz2
3rdparty-bcm5700-1.4.5.tar.bz2
3rdparty-dc395x_trm-1.32-cpp-fixes.patch.bz2
3rdparty-dc395x_trm-1.32.tar.bz2
3rdparty-e100-1.6.5.tar.bz2
3rdparty-e1000-3.0.10.tar.bz2
3rdparty-qce-ga-0.40b.tar.bz2
README.kernel-sources
alsa-driver-0.5.11-compile-fix.patch.bz2
alsa-driver-0.5.11-compile-fix2.patch.bz2
alsa-driver-0.5.11.tar.bz2
boot_logo.ppm.bz2
endian-safe-reiserfs-for-2.4.6-pre8.patch.bz2
freeswan-1.91-fix-debug.patch.bz2
freeswan-1.91.tar.bz2
i2c-2.6.0.tar.bz2
kernel-2.4-BuildASM.sh
kernel-2.4.8-alpha.config
kernel-2.4.8-i586-BOOT.config
kernel-2.4.8-i586-enterprise.config
kernel-2.4.8-i586.config
kernel-2.4.8-ppc.config
kernel-2.4.spec
linux-2.2.1-ac19-fix-ipsec-include.patch.bz2
linux-2.2.16-useio.patch.bz2
linux-2.3.99p3p6-sparc.patch.bz2
linux-2.4.0-ac12-nohighmemdebug.patch.bz2
linux-2.4.0-pcmcia-3.1.23-cp-force.patch.bz2
linux-2.4.0-ping.patch.bz2
linux-2.4.0-test5-qla1280-1.patch.bz2
linux-2.4.1-ac11-installkernel-a.patch.bz2
linux-2.4.1-ac19-ipsec-config-1.8.patch.bz2
linux-2.4.1-ac3-qla2x00-2.19.15.patch.bz2
linux-2.4.1-ac4-3c90x.patch.bz2
linux-2.4.1-ac4-e820.patch.bz2
linux-2.4.1-ac4-raid5xor.patch.bz2
linux-2.4.1-ac4-wavelan-udelay.patch.bz2
linux-2.4.2-ac16-aty-modules.patch.bz2
linux-2.4.2-ac20-alpha-include.patch.bz2
linux-2.4.2-ac20-alternateairo.patch.bz2
linux-2.4.2-ac20-i2o-lockup.patch.bz2
linux-2.4.2-ac20-qla1280timer.patch.bz2
linux-2.4.2-ac20-quiet-cdrom.patch.bz2
linux-2.4.2-ac20-uhci-slab.patch.bz2
linux-2.4.2-ac28-cipefix.patch.bz2
linux-2.4.2-ac28-ipvs-compile-fix.patch.bz2
linux-2.4.3-ac12-r5align.patch.bz2
linux-2.4.3-ac12-r5plug.patch.bz2
linux-2.4.3-ac13-keyboardsilence.patch.bz2
linux-2.4.3-ac3-bootlogo-leave-message.patch.bz2
linux-2.4.3-ac3-pcmcia-rc-early.patch.bz2
linux-2.4.3-ac4-bootmem.patch.bz2
linux-2.4.3-ac4-bootmem_oom.patch.bz2
linux-2.4.3-ac4-nologo.patch.bz2
linux-2.4.3-ac4-usb-scsiglue.patch.bz2
linux-2.4.3-isdn-olitec-gazel.patch.bz2
linux-2.4.3-mdk-bootlogo.patch.bz2
linux-2.4.3-rev-p30-ppc.patch.bz2
linux-2.4.3-usb-module_device_table.patch.bz2
linux-2.4.4-ac11-ppptoe-ppptoa.patch.bz2
linux-2.4.4-ac11-usbthrottle.patch.bz2
linux-2.4.4-ac3-blkioctl-sector.patch.bz2
linux-2.4.4-ac3-lp-parport-revert.patch.bz2
linux-2.4.5-ac13-driver-tw98_0.1.patch.bz2
linux-2.4.5-ac13-iforce.update.patch.bz2
linux-2.4.5-ac13-usbvision-device-map.patch.bz2
linux-2.4.5-ac15-autoconf.patch.bz2
linux-2.4.5-ac15-kaweth-fix.patch.bz2
linux-2.4.5-ac15-netfilter-dropped-table.patch.bz2
linux-2.4.5-ac15-netfilter-irc-nat.patch.bz2
linux-2.4.5-ac5-ide-cd-fix.patch.bz2
linux-2.4.6-ac1-cipe-1.4.5.patch.bz2
linux-2.4.6-ac1-hexblocknumbers.patch.bz2
linux-2.4.6-ac1-ipvs.patch.bz2
linux-2.4.6-ac2-du-e100.support.patch.bz2
linux-2.4.6-ac2-silicom-u2e.support.patch.bz2
linux-2.4.6-ac5-supermount-0.6.0.patch.bz2
linux-2.4.6-lm_sensors-ppc.patch.bz2
linux-2.4.6-misc-ppc.patch.bz2
linux-2.4.7-ac1-aacraid.patch.bz2
linux-2.4.7-ac1-mediactl-0.0.2.patch.bz2
linux-2.4.7-ac1-sard.patch.bz2
linux-2.4.7-ac10-lanstreamer-update.patch.bz2
linux-2.4.7-ac2-fix-rebuild-aic7xx-firmware.patch.bz2
linux-2.4.7-ac2-kdb-fix.patch.bz2
linux-2.4.7-ac2-reiserfs-quota.patch.bz2
linux-2.4.7-ac3-hp8200.patch.bz2
linux-2.4.7-ac3-speedtouch.patch.bz2
linux-2.4.7-ac3-usbvision.patch.bz2
linux-2.4.7-ac4-3rdparty.patch.bz2
linux-2.4.7-ac4-jfs-1.0.2-common.patch.bz2
linux-2.4.7-ac5-bootlogo_with_version.patch.bz2
linux-2.4.7-ac5-multipath.patch.bz2
linux-2.4.7-ac7-BOOT.patch.bz2
linux-2.4.7-ac7-bcm5820-2.patch.bz2
linux-2.4.7-ac7-bcm5820.patch.bz2
linux-2.4.7-ac7-jfs-1.0.2-shared.patch.bz2
linux-2.4.8-ac2-atm-fixes.patch.bz2
linux-2.4.8-ac2-nec-picty900-printer.patch.bz2
linux-2.4.8-ac3-parportpnp.patch.bz2
linux-2.4.8-ac3-sb_id.patch.bz2
linux-2.4.8-ac5-config-small.patch.bz2
linux-2.4.8-ac7-cramfs.patch.bz2
linux-2.4.8-ac7-dellmptable.patch.bz2
linux-2.4.8-ac7-ethtool.patch.bz2
linux-2.4.8-ac7-ext3-debug.patch.bz2
linux-2.4.8-ac7-kdb-v1.8.patch.bz2
linux-2.4.8-ac7-keyboardsilence.patch.bz2
linux-2.4.8-ac7-massworks-id75.patch.bz2
linux-2.4.8-ac7-numargs.patch.bz2
linux-2.4.8-ac7-oomavoidance.patch.bz2
linux-2.4.8-ac7-parport-update.patch.bz2
linux-2.4.8-ac7-pdcraid.patch.bz2
linux-2.4.8-ac7-scsitimeout.patch.bz2
linux-2.4.8-ac7-sym53c8xx-fixes.patch.bz2
linux-2.4.8-ac7-triplelock.patch.bz2
linux-2.4.8-ac7-usb-oops.patch.bz2
linux-2.4.8-ac7-usb-sony-clie.patch.bz2
linux-2.4.8-ac7-vfatnfs.patch.bz2
linux-2.4.8-ac7-vlan-1.4.patch.bz2
linux-2.4.8-ac7-xircom-pgsdb9.patch.bz2
linux-2.4.8.tar.bz2
linux-mdkconfig.h
linux-merge-config.awk
linux-merge-modules.awk
lm_sensors-2.5.5-fix-build-sensord.patch.bz2
lm_sensors-2.5.5-fix-install.patch.bz2
lm_sensors-2.5.5-sensors
lm_sensors-2.6.0-mkpatch-fix.patch.bz2
lm_sensors-2.6.0.tar.bz2
pcmcia-cs-3.1.21-config.patch.bz2
pcmcia-cs-3.1.21-script.patch.bz2
pcmcia-cs-3.1.25-sysconfig-pcmcia
pcmcia-cs-3.1.26-wireless.patch.bz2
pcmcia-cs-3.1.27-Configure-fix.patch.bz2
pcmcia-cs-3.1.27-isdn.script
pcmcia-cs-3.1.27-network.script
pcmcia-cs-3.1.27-ohci_update.patch.bz2
pcmcia-cs-3.1.27-spectrum-2.4t.patch.bz2
pcmcia-cs-3.1.27-updfstab.patch.bz2
pcmcia-cs-3.1.27-yenta.patch.bz2
pcmcia-cs-3.1.28-ibmtr_compile_fix.patch.bz2
pcmcia-cs-3.1.28.tar.bz2
pcmcia-cs-3.1.2x-no-aero-ppc.patch.bz2
pcmcia-cs-3.1.3-3com.patch.bz2
rhkmvtag.c
supermount.README


ftp.sunet.se:/pub/Linux/distributions/mandrake-devel/cooker/i586/Mandrake/RPMS/
              kernel-smp-2.4.8-7mdk.i586.rpm
