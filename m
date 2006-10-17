Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWJQTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWJQTPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWJQTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:15:51 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:35343 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751038AbWJQTPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:15:49 -0400
Date: Tue, 17 Oct 2006 15:15:22 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 19-rc2]  Fix misc .c/.h comment typos
Message-Id: <20061017151522.16ad8526.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 17 Oct 2006 15:15:38 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 17 Oct 2006 15:15:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various .c/.h typos in comments (no code changes).

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/arch/cris/arch-v10/drivers/eeprom.c b/arch/cris/arch-v10/drivers/eeprom.c
--- a/arch/cris/arch-v10/drivers/eeprom.c	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/cris/arch-v10/drivers/eeprom.c	2006-10-14 21:07:45.000000000 -0400
@@ -1,7 +1,7 @@
 /*!*****************************************************************************
 *!
-*!  Implements an interface for i2c compatible eeproms to run under linux.
-*!  Supports 2k, 8k(?) and 16k. Uses adaptive timing adjustents by
+*!  Implements an interface for i2c compatible eeproms to run under Linux.
+*!  Supports 2k, 8k(?) and 16k. Uses adaptive timing adjustments by
 *!  Johan.Adolfsson@axis.com
 *!
 *!  Probing results:
@@ -51,7 +51,7 @@
 *!  Revision 1.8  2001/06/15 13:24:29  jonashg
 *!  * Added verification of pointers from userspace in read and write.
 *!  * Made busy counter volatile.
-*!  * Added define for inital write delay.
+*!  * Added define for initial write delay.
 *!  * Removed warnings by using loff_t instead of unsigned long.
 *!
 *!  Revision 1.7  2001/06/14 15:26:54  jonashg
diff -ru a/arch/cris/arch-v10/drivers/i2c.c b/arch/cris/arch-v10/drivers/i2c.c
--- a/arch/cris/arch-v10/drivers/i2c.c	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/cris/arch-v10/drivers/i2c.c	2006-10-14 21:05:07.000000000 -0400
@@ -47,7 +47,7 @@
 *! Update Port B register and shadow even when running with hardware support
 *!   to avoid glitches when reading bits
 *! Never set direction to out in i2c_inbyte
-*! Removed incorrect clock togling at end of i2c_inbyte
+*! Removed incorrect clock toggling at end of i2c_inbyte
 *!
 *! Revision 1.8  2002/08/13 06:31:53  starvik
 *! Made SDA and SCL line configurable
diff -ru a/arch/cris/arch-v10/kernel/kgdb.c b/arch/cris/arch-v10/kernel/kgdb.c
--- a/arch/cris/arch-v10/kernel/kgdb.c	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/cris/arch-v10/kernel/kgdb.c	2006-10-14 21:31:28.000000000 -0400
@@ -33,7 +33,7 @@
 *!
 *! Revision 1.2  2002/11/19 14:35:24  starvik
 *! Changes from linux 2.4
-*! Changed struct initializer syntax to the currently prefered notation
+*! Changed struct initializer syntax to the currently preferred notation
 *!
 *! Revision 1.1  2001/12/17 13:59:27  bjornw
 *! Initial revision
diff -ru a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
--- a/arch/ia64/hp/common/sba_iommu.c	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/ia64/hp/common/sba_iommu.c	2006-10-14 21:49:37.000000000 -0400
@@ -75,7 +75,7 @@
 ** If a device prefetches beyond the end of a valid pdir entry, it will cause
 ** a hard failure, ie. MCA.  Version 3.0 and later of the zx1 LBA should
 ** disconnect on 4k boundaries and prevent such issues.  If the device is
-** particularly agressive, this option will keep the entire pdir valid such
+** particularly aggressive, this option will keep the entire pdir valid such
 ** that prefetching will hit a valid address.  This could severely impact
 ** error containment, and is therefore off by default.  The page that is
 ** used for spill-over is poisoned, so that should help debugging somewhat.
@@ -258,10 +258,10 @@
 
 /*
 ** DMA_CHUNK_SIZE is used by the SCSI mid-layer to break up
-** (or rather not merge) DMA's into managable chunks.
+** (or rather not merge) DMAs into manageable chunks.
 ** On parisc, this is more of the software/tuning constraint
-** rather than the HW. I/O MMU allocation alogorithms can be
-** faster with smaller size is (to some degree).
+** rather than the HW. I/O MMU allocation algorithms can be
+** faster with smaller sizes (to some degree).
 */
 #define DMA_CHUNK_SIZE  (BITS_PER_LONG*iovp_size)
 
diff -ru a/arch/sh64/lib/dbg.c b/arch/sh64/lib/dbg.c
--- a/arch/sh64/lib/dbg.c	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/sh64/lib/dbg.c	2006-10-14 20:58:18.000000000 -0400
@@ -383,7 +383,7 @@
 /* ======================================================================= */
 
 /*
-** Depending on <base> scan the MMU, Data or Instrction side
+** Depending on <base> scan the MMU, Data or Instruction side
 ** looking for a valid mapping matching Eaddr & asid.
 ** Return -1 if not found or the TLB id entry otherwise.
 ** Note: it works only for 4k pages!
diff -ru a/drivers/atm/iphase.c b/drivers/atm/iphase.c
--- a/drivers/atm/iphase.c	2006-10-14 20:32:05.000000000 -0400
+++ b/drivers/atm/iphase.c	2006-10-14 21:35:17.000000000 -0400
@@ -305,7 +305,7 @@
 **  |  R | NZ |  5-bit exponent  |        9-bit mantissa         |
 **  +----+----+------------------+-------------------------------+
 ** 
-**    R = reserverd (written as 0)
+**    R = reserved (written as 0)
 **    NZ = 0 if 0 cells/sec; 1 otherwise
 **
 **    if NZ = 1, rate = 1.mmmmmmmmm x 2^(eeeee) cells/sec
diff -ru a/drivers/char/rio/riocmd.c b/drivers/char/rio/riocmd.c
--- a/drivers/char/rio/riocmd.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/char/rio/riocmd.c	2006-10-14 21:41:34.000000000 -0400
@@ -922,7 +922,7 @@
 ** 
 ** Packet is an actual packet structure to be filled in with the packet
 ** information associated with the command. You need to fill in everything,
-** as the command processore doesn't process the command packet in any way.
+** as the command processor doesn't process the command packet in any way.
 ** 
 ** The PreFuncP is called before the packet is enqueued on the host rup.
 ** PreFuncP is called as (*PreFuncP)(PreArg, CmdBlkP);. PreFuncP must
diff -ru a/drivers/char/rio/rioinit.c b/drivers/char/rio/rioinit.c
--- a/drivers/char/rio/rioinit.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/char/rio/rioinit.c	2006-10-14 21:21:56.000000000 -0400
@@ -222,7 +222,7 @@
 ** which value will be written into memory.
 ** Call with op set to zero means that the RAM will not be read and checked
 ** before it is written.
-** Call with op not zero, and the RAM will be read and compated with val[op-1]
+** Call with op not zero and the RAM will be read and compared with val[op-1]
 ** to check that the data from the previous phase was retained.
 */
 
diff -ru a/drivers/char/rio/rioparam.c b/drivers/char/rio/rioparam.c
--- a/drivers/char/rio/rioparam.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/char/rio/rioparam.c	2006-10-14 21:27:47.000000000 -0400
@@ -87,8 +87,8 @@
 ** command bit set onto the port. The command bit is in the len field,
 ** and gets ORed in with the actual byte count.
 **
-** When you send a packet with the command bit set, then the first
-** data byte ( data[0] ) is interpretted as the command to execute.
+** When you send a packet with the command bit set the first
+** data byte (data[0]) is interpreted as the command to execute.
 ** It also governs what data structure overlay should accompany the packet.
 ** Commands are defined in cirrus/cirrus.h
 **
@@ -103,7 +103,7 @@
 **
 ** Most commands do not use the remaining bytes in the data array. The
 ** exceptions are OPEN MOPEN and CONFIG. (NB. As with the SI CONFIG and
-** OPEN are currently analagous). With these three commands the following
+** OPEN are currently analogous). With these three commands the following
 ** 11 data bytes are all used to pass config information such as baud rate etc.
 ** The fields are also defined in cirrus.h. Some contain straightforward
 ** information such as the transmit XON character. Two contain the transmit and
diff -ru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2006-10-14 20:32:06.000000000 -0400
+++ b/drivers/ide/ide-floppy.c	2006-10-14 21:32:02.000000000 -0400
@@ -1635,7 +1635,7 @@
 /*
 ** Get ATAPI_FORMAT_UNIT progress indication.
 **
-** Userland gives a pointer to an int.  The int is set to a progresss
+** Userland gives a pointer to an int.  The int is set to a progress
 ** indicator 0-65536, with 65536=100%.
 **
 ** If the drive does not support format progress indication, we just check
diff -ru a/drivers/isdn/hardware/eicon/os_4bri.c b/drivers/isdn/hardware/eicon/os_4bri.c
--- a/drivers/isdn/hardware/eicon/os_4bri.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/isdn/hardware/eicon/os_4bri.c	2006-10-14 20:56:42.000000000 -0400
@@ -464,7 +464,7 @@
 
 /*
 **  Cleanup function will be called for master adapter only
-**  this is garanteed by design: cleanup callback is set
+**  this is guaranteed by design: cleanup callback is set
 **  by master adapter only
 */
 static int diva_4bri_cleanup_adapter(diva_os_xdi_adapter_t * a)
diff -ru a/drivers/isdn/hisax/hfc4s8s_l1.h b/drivers/isdn/hisax/hfc4s8s_l1.h
--- a/drivers/isdn/hisax/hfc4s8s_l1.h	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/isdn/hisax/hfc4s8s_l1.h	2006-10-14 21:20:26.000000000 -0400
@@ -16,7 +16,7 @@
 
 /*
 *  include Genero generated HFC-4S/8S header file hfc48scu.h
-*  for comlete register description. This will define _HFC48SCU_H_
+*  for complete register description. This will define _HFC48SCU_H_
 *  to prevent redefinitions
 */
 
diff -ru a/drivers/media/dvb/ttpci/budget-patch.c b/drivers/media/dvb/ttpci/budget-patch.c
--- a/drivers/media/dvb/ttpci/budget-patch.c	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/media/dvb/ttpci/budget-patch.c	2006-10-14 21:43:03.000000000 -0400
@@ -500,14 +500,14 @@
 
 /*      New design (By Emard)
 **      this rps1 code will copy internal HS event to GPIO3 pin.
-**      GPIO3 is in budget-patch hardware connectd to port B VSYNC
+**      GPIO3 is in budget-patch hardware connected to port B VSYNC
 
 **      HS is an internal event of 7146, accessible with RPS
 **      and temporarily raised high every n lines
 **      (n in defined in the RPS_THRESH1 counter threshold)
 **      I think HS is raised high on the beginning of the n-th line
 **      and remains high until this n-th line that triggered
-**      it is completely received. When the receiption of n-th line
+**      it is completely received. When the reception of n-th line
 **      ends, HS is lowered.
 
 **      To transmit data over DMA, 7146 needs changing state at
@@ -541,7 +541,7 @@
 **      hardware debug note: a working budget card (including budget patch)
 **      with vpeirq() interrupt setup in mode "0x90" (every 64K) will
 **      generate 3 interrupts per 25-Hz DMA frame of 2*188*512 bytes
-**      and that means 3*25=75 Hz of interrupt freqency, as seen by
+**      and that means 3*25=75 Hz of interrupt frequency, as seen by
 **      watch cat /proc/interrupts
 **
 **      If this frequency is 3x lower (and data received in the DMA
@@ -550,7 +550,7 @@
 **      this means VSYNC line is not connected in the hardware.
 **      (check soldering pcb and pins)
 **      The same behaviour of missing VSYNC can be duplicated on budget
-**      cards, by seting DD1_INIT trigger mode 7 in 3rd nibble.
+**      cards, by setting DD1_INIT trigger mode 7 in 3rd nibble.
 */
 
 	// Setup RPS1 "program" (p35)
diff -ru a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
--- a/drivers/net/e1000/e1000_hw.c	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/net/e1000/e1000_hw.c	2006-10-14 21:01:38.000000000 -0400
@@ -3868,7 +3868,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 *
-* Sets bit 15 of the MII Control regiser
+* Sets bit 15 of the MII Control register
 ******************************************************************************/
 int32_t
 e1000_phy_reset(struct e1000_hw *hw)
diff -ru a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/net/e100.c	2006-10-14 21:07:30.000000000 -0400
@@ -1215,7 +1215,7 @@
 *  the literal in the instruction before the code is loaded, the
 *  driver can change the algorithm.
 *
-*  INTDELAY - This loads the dead-man timer with its inital value.
+*  INTDELAY - This loads the dead-man timer with its initial value.
 *    When this timer expires the interrupt is asserted, and the
 *    timer is reset each time a new packet is received.  (see
 *    BUNDLEMAX below to set the limit on number of chained packets)
diff -ru a/drivers/net/sk98lin/h/skdrv2nd.h b/drivers/net/sk98lin/h/skdrv2nd.h
--- a/drivers/net/sk98lin/h/skdrv2nd.h	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/net/sk98lin/h/skdrv2nd.h	2006-10-14 21:24:58.000000000 -0400
@@ -160,7 +160,7 @@
 
 /*
 ** Interim definition of SK_DRV_TIMER placed in this file until 
-** common modules have boon finallized
+** common modules have been finalized
 */
 #define SK_DRV_TIMER			11 
 #define	SK_DRV_MODERATION_TIMER		1
diff -ru a/drivers/net/sk98lin/skdim.c b/drivers/net/sk98lin/skdim.c
--- a/drivers/net/sk98lin/skdim.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/net/sk98lin/skdim.c	2006-10-14 21:34:43.000000000 -0400
@@ -252,7 +252,7 @@
 
 /*******************************************************************************
 ** Function     : SkDimDisplayModerationSettings
-** Description  : Displays the current settings regaring interrupt moderation
+** Description  : Displays the current settings regarding interrupt moderation
 ** Programmer   : Ralph Roesler
 ** Last Modified: 22-mar-03
 ** Returns      : void (!)
@@ -510,7 +510,7 @@
 
 /*******************************************************************************
 ** Function     : DisableIntMod()
-** Description  : Disbles the interrupt moderation independent of what inter-
+** Description  : Disables the interrupt moderation independent of what inter-
 **                rupts are running or not
 ** Programmer   : Ralph Roesler
 ** Last Modified: 23-mar-03
diff -ru a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c	2006-10-14 20:32:20.000000000 -0400
+++ b/drivers/net/wireless/ipw2200.c	2006-10-14 21:36:29.000000000 -0400
@@ -6920,8 +6920,8 @@
 }
 
 /*
-* handling the beaconing responces. if we get different QoS setting
-* of the network from the the associated setting adjust the QoS
+* handling the beaconing responses. if we get different QoS setting
+* off the network from the associated setting, adjust the QoS
 * setting
 */
 static int ipw_qos_association_resp(struct ipw_priv *priv,
diff -ru a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
--- a/drivers/parisc/ccio-dma.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/parisc/ccio-dma.c	2006-10-14 20:47:14.000000000 -0400
@@ -486,7 +486,7 @@
 **   This bit tells U2 to do R/M/W for partial cachelines. "Streaming"
 **   data can avoid this if the mapping covers full cache lines.
 ** o STOP_MOST is needed for atomicity across cachelines.
-**   Apperently only "some EISA devices" need this.
+**   Apparently only "some EISA devices" need this.
 **   Using CONFIG_ISA is hack. Only the IOA with EISA under it needs
 **   to use this hint iff the EISA devices needs this feature.
 **   According to the U2 ERS, STOP_MOST enabled pages hurt performance.
diff -ru a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
--- a/drivers/parisc/iosapic.c	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/parisc/iosapic.c	2006-10-14 21:32:53.000000000 -0400
@@ -50,12 +50,12 @@
 **
 ** PA Firmware
 ** -----------
-** PA-RISC platforms have two fundementally different types of firmware.
+** PA-RISC platforms have two fundamentally different types of firmware.
 ** For PCI devices, "Legacy" PDC initializes the "INTERRUPT_LINE" register
 ** and BARs similar to a traditional PC BIOS.
 ** The newer "PAT" firmware supports PDC calls which return tables.
-** PAT firmware only initializes PCI Console and Boot interface.
-** With these tables, the OS can progam all other PCI devices.
+** PAT firmware only initializes the PCI Console and Boot interface.
+** With these tables, the OS can program all other PCI devices.
 **
 ** One such PAT PDC call returns the "Interrupt Routing Table" (IRT).
 ** The IRT maps each PCI slot's INTA-D "output" line to an I/O SAPIC
diff -ru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	2006-10-14 21:11:57.000000000 -0400
@@ -531,7 +531,7 @@
 *
 * Action:  issue a READ command to HPC
 *
-* Input:   pslot   - can not be NULL for READ_ALLSTAT
+* Input:   pslot   - cannot be NULL for READ_ALLSTAT
 *          pstatus - can be NULL for READ_ALLSTAT
 *
 * Return   0 or error codes
diff -ru a/drivers/s390/net/claw.h b/drivers/s390/net/claw.h
--- a/drivers/s390/net/claw.h	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/s390/net/claw.h	2006-10-14 21:19:49.000000000 -0400
@@ -29,7 +29,7 @@
 #define CLAW_COMPLETE           0xff   /* flag to indicate i/o completed */
 
 /*-----------------------------------------------------*
-*     CLAW control comand code                         *
+*     CLAW control command code                        *
 *------------------------------------------------------*/
 
 #define SYSTEM_VALIDATE_REQUEST   0x01  /* System Validate request */
diff -ru a/drivers/scsi/aic94xx/aic94xx_reg_def.h b/drivers/scsi/aic94xx/aic94xx_reg_def.h
--- a/drivers/scsi/aic94xx/aic94xx_reg_def.h	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/scsi/aic94xx/aic94xx_reg_def.h	2006-10-14 21:19:01.000000000 -0400
@@ -2000,7 +2000,7 @@
  * The host accesses this scratch in a different manner from the
  * central sequencer. The sequencer has to use CSEQ registers CSCRPAGE
  * and CMnSCRPAGE to access the scratch memory. A flat mapping of the
- * scratch memory is avaliable for software convenience and to prevent
+ * scratch memory is available for software convenience and to prevent
  * corruption while the sequencer is running. This memory is mapped
  * onto addresses 800h - BFFh, total of 400h bytes.
  *
diff -ru a/drivers/scsi/aic94xx/aic94xx_sds.c b/drivers/scsi/aic94xx/aic94xx_sds.c
--- a/drivers/scsi/aic94xx/aic94xx_sds.c	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/scsi/aic94xx/aic94xx_sds.c	2006-10-14 21:51:06.000000000 -0400
@@ -64,7 +64,7 @@
 
 #define OCM_INIT_DIR_ENTRIES	5
 /***************************************************************************
-*  OCM dircetory default
+*  OCM directory default
 ***************************************************************************/
 static struct asd_ocm_dir OCMDirInit =
 {
@@ -73,7 +73,7 @@
 };
 
 /***************************************************************************
-*  OCM dircetory Entries default
+*  OCM directory Entries default
 ***************************************************************************/
 static struct asd_ocm_dir_ent OCMDirEntriesInit[OCM_INIT_DIR_ENTRIES] =
 {
diff -ru a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
--- a/drivers/scsi/ncr53c8xx.c	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/scsi/ncr53c8xx.c	2006-10-14 21:43:49.000000000 -0400
@@ -185,7 +185,7 @@
 **	power of 2 cache line size.
 **	Enhanced in linux-2.3.44 to provide a memory pool 
 **	per pcidev to support dynamic dma mapping. (I would 
-**	have preferred a real bus astraction, btw).
+**	have preferred a real bus abstraction, btw).
 **
 **==========================================================
 */
@@ -1438,7 +1438,7 @@
 **	The first four bytes (scr_st[4]) are used inside the script by 
 **	"COPY" commands.
 **	Because source and destination must have the same alignment
-**	in a DWORD, the fields HAVE to be at the choosen offsets.
+**	in a DWORD, the fields HAVE to be at the chosen offsets.
 **		xerr_st		0	(0x34)	scratcha
 **		sync_st		1	(0x05)	sxfer
 **		wide_st		3	(0x03)	scntl3
@@ -1498,7 +1498,7 @@
 **	the DSA (data structure address) register points
 **	to this substructure of the ccb.
 **	This substructure contains the header with
-**	the script-processor-changable data and
+**	the script-processor-changeable data and
 **	data blocks for the indirect move commands.
 **
 **----------------------------------------------------------
@@ -5107,7 +5107,7 @@
 
 /*
 **	This CCB has been skipped by the NCR.
-**	Queue it in the correponding unit queue.
+**	Queue it in the corresponding unit queue.
 */
 static void ncr_ccb_skipped(struct ncb *np, struct ccb *cp)
 {
@@ -5896,8 +5896,8 @@
 **
 **	In normal cases, interrupt conditions occur one at a 
 **	time. The ncr is able to stack in some extra registers 
-**	other interrupts that will occurs after the first one.
-**	But severall interrupts may occur at the same time.
+**	other interrupts that will occur after the first one.
+**	But, several interrupts may occur at the same time.
 **
 **	We probably should only try to deal with the normal 
 **	case, but it seems that multiple interrupts occur in 
@@ -6796,7 +6796,7 @@
 **	The host status field is set to HS_NEGOTIATE to mark this
 **	situation.
 **
-**	If the target doesn't answer this message immidiately
+**	If the target doesn't answer this message immediately
 **	(as required by the standard), the SIR_NEGO_FAIL interrupt
 **	will be raised eventually.
 **	The handler removes the HS_NEGOTIATE status, and sets the
diff -ru a/drivers/scsi/ncr53c8xx.h b/drivers/scsi/ncr53c8xx.h
--- a/drivers/scsi/ncr53c8xx.h	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/scsi/ncr53c8xx.h	2006-10-14 21:47:20.000000000 -0400
@@ -218,7 +218,7 @@
 **	Same as option 1, but also deal with 
 **	misconfigured interrupts.
 **
-**	- Edge triggerred instead of level sensitive.
+**	- Edge triggered instead of level sensitive.
 **	- No interrupt line connected.
 **	- IRQ number misconfigured.
 **	
@@ -549,7 +549,7 @@
 
 /*
 **	Initial setup.
-**	Can be overriden at startup by a command line.
+**	Can be overridden at startup by a command line.
 */
 #define SCSI_NCR_DRIVER_SETUP			\
 {						\
@@ -1093,7 +1093,7 @@
 **-----------------------------------------------------------
 **	On 810A, 860, 825A, 875, 895 and 896 chips the content 
 **	of SFBR register can be used as data (SCR_SFBR_DATA).
-**	The 896 has additionnal IO registers starting at 
+**	The 896 has additional IO registers starting at 
 **	offset 0x80. Bit 7 of register offset is stored in 
 **	bit 7 of the SCRIPTS instruction first DWORD.
 **-----------------------------------------------------------
diff -ru a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
--- a/drivers/usb/host/u132-hcd.c	2006-10-14 20:32:22.000000000 -0400
+++ b/drivers/usb/host/u132-hcd.c	2006-10-14 21:18:16.000000000 -0400
@@ -211,7 +211,7 @@
 int usb_ftdi_elan_write_pcimem(struct platform_device *pdev, u8 addressofs,
         u8 width, u32 data);
 /*
-* these can not be inlines because we need the structure offset!!
+* these cannot be inlines because we need the structure offset!!
 * Does anyone have a better way?????
 */
 #define u132_read_pcimem(u132, member, data) \
@@ -3045,7 +3045,7 @@
 * This function may be called by the USB core whilst the "usb_all_devices_rwsem"
 * is held for writing, thus this module must not call usb_remove_hcd()
 * synchronously - but instead should immediately stop activity to the
-* device and ansynchronously call usb_remove_hcd()
+* device and asynchronously call usb_remove_hcd()
 */
 static int __devexit u132_remove(struct platform_device *pdev)
 {
@@ -3241,7 +3241,7 @@
 #define u132_resume NULL
 #endif
 /*
-* this driver is loaded explicitely by ftdi_u132
+* this driver is loaded explicitly by ftdi_u132
 *
 * the platform_driver struct is static because it is per type of module
 */
diff -ru a/drivers/usb/misc/usb_u132.h b/drivers/usb/misc/usb_u132.h
--- a/drivers/usb/misc/usb_u132.h	2006-10-14 20:32:22.000000000 -0400
+++ b/drivers/usb/misc/usb_u132.h	2006-10-14 21:42:05.000000000 -0400
@@ -52,7 +52,7 @@
 * the kernel to load the "u132-hcd" module.
 *
 * The "ftdi-u132" module provides the interface to the inserted
-* PC card and the "u132-hcd" module uses the API to send and recieve
+* PC card and the "u132-hcd" module uses the API to send and receive
 * data. The API features call-backs, so that part of the "u132-hcd"
 * module code will run in the context of one of the kernel threads
 * of the "ftdi-u132" module.
diff -ru a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
--- a/drivers/usb/serial/digi_acceleport.c	2006-10-14 20:32:22.000000000 -0400
+++ b/drivers/usb/serial/digi_acceleport.c	2006-10-14 21:16:09.000000000 -0400
@@ -157,7 +157,7 @@
 *       to TASK_RUNNING will be lost and write_chan's subsequent call to
 *       schedule() will never return (unless it catches a signal).
 *       This race condition occurs because write_bulk_callback() (and thus
-*       the wakeup) are called asynchonously from an interrupt, rather than
+*       the wakeup) are called asynchronously from an interrupt, rather than
 *       from the scheduler.  We can avoid the race by calling the wakeup
 *       from the scheduler queue and that's our fix:  Now, at the end of
 *       write_bulk_callback() we queue up a wakeup call on the scheduler
diff -ru a/drivers/video/cyberfb.c b/drivers/video/cyberfb.c
--- a/drivers/video/cyberfb.c	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/video/cyberfb.c	2006-10-14 20:54:40.000000000 -0400
@@ -61,7 +61,7 @@
 * Revision 1.3  1998/08/17 06:21:53  abair
 * Remove more redundant code after merging in cvision_core.c
 * Set blanking by colormap to pale red to detect this vs trying to
-* use video blanking. More formating to Linux code style.
+* use video blanking. More formatting to Linux code style.
 *
 * Revision 1.2  1998/08/15 17:51:37  abair
 * Added cvision_core.c code from 2.1.35 patches.
diff -ru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	2006-10-14 20:32:24.000000000 -0400
+++ b/fs/reiserfs/journal.c	2006-10-14 21:21:08.000000000 -0400
@@ -1463,7 +1463,7 @@
 		}
 
 		/* if someone has this block in a newer transaction, just make
-		 ** sure they are commited, and don't try writing it to disk
+		 ** sure they are committed, and don't try writing it to disk
 		 */
 		if (pjl) {
 			if (atomic_read(&pjl->j_commit_left))
@@ -3383,7 +3383,7 @@
 
 /*
 ** for any cnode in a journal list, it can only be dirtied of all the
-** transactions that include it are commited to disk.
+** transactions that include it are committed to disk.
 ** this checks through each transaction, and returns 1 if you are allowed to dirty,
 ** and 0 if you aren't
 **
@@ -3425,7 +3425,7 @@
 }
 
 /* syncs the commit blocks, but does not force the real buffers to disk
-** will wait until the current transaction is done/commited before returning 
+** will wait until the current transaction is done/committed before returning 
 */
 int journal_end_sync(struct reiserfs_transaction_handle *th,
 		     struct super_block *p_s_sb, unsigned long nblocks)
diff -ru a/include/asm-m68knommu/mcfmbus.h b/include/asm-m68knommu/mcfmbus.h
--- a/include/asm-m68knommu/mcfmbus.h	2006-09-19 23:42:06.000000000 -0400
+++ b/include/asm-m68knommu/mcfmbus.h	2006-10-14 21:38:27.000000000 -0400
@@ -37,7 +37,7 @@
 #define MCFMBUS_MFDR_MBC(a)	((a)&0x3F)	   /*M-Bus Clock*/
 
 /*
-*	Define bit flags in Controll Register
+*	Define bit flags in Control Register
 */
 
 #define MCFMBUS_MBCR_MEN           (0x80)  /* M-Bus Enable                 */
diff -ru a/include/asm-parisc/dma.h b/include/asm-parisc/dma.h
--- a/include/asm-parisc/dma.h	2006-10-14 20:32:24.000000000 -0400
+++ b/include/asm-parisc/dma.h	2006-10-14 21:49:59.000000000 -0400
@@ -17,10 +17,10 @@
 
 /*
 ** DMA_CHUNK_SIZE is used by the SCSI mid-layer to break up
-** (or rather not merge) DMA's into managable chunks.
+** (or rather not merge) DMAs into manageable chunks.
 ** On parisc, this is more of the software/tuning constraint
-** rather than the HW. I/O MMU allocation alogorithms can be
-** faster with smaller size is (to some degree).
+** rather than the HW. I/O MMU allocation algorithms can be
+** faster with smaller sizes (to some degree).
 */
 #define DMA_CHUNK_SIZE	(BITS_PER_LONG*PAGE_SIZE)
 
diff -ru a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h	2006-10-14 20:32:24.000000000 -0400
+++ b/include/asm-parisc/pci.h	2006-10-14 21:33:31.000000000 -0400
@@ -149,7 +149,7 @@
 /*
 ** Most PCI devices (eg Tulip, NCR720) also export the same registers
 ** to both MMIO and I/O port space.  Due to poor performance of I/O Port
-** access under HP PCI bus adapters, strongly reccomend use of MMIO
+** access under HP PCI bus adapters, strongly recommend the use of MMIO
 ** address space.
 **
 ** While I'm at it more PA programming notes:
diff -ru a/include/asm-parisc/ropes.h b/include/asm-parisc/ropes.h
--- a/include/asm-parisc/ropes.h	2006-10-14 20:32:24.000000000 -0400
+++ b/include/asm-parisc/ropes.h	2006-10-14 21:39:24.000000000 -0400
@@ -14,7 +14,7 @@
 #endif
 
 /*
-** The number of pdir entries to "free" before issueing
+** The number of pdir entries to "free" before issuing
 ** a read to PCOM register to flush out PCOM writes.
 ** Interacts with allocation granularity (ie 4 or 8 entries
 ** allocated and free'd/purged at a time might make this
diff -ru a/include/linux/ixjuser.h b/include/linux/ixjuser.h
--- a/include/linux/ixjuser.h	2006-09-19 23:42:06.000000000 -0400
+++ b/include/linux/ixjuser.h	2006-10-14 21:28:25.000000000 -0400
@@ -315,7 +315,7 @@
 * structures.  If the freq0 variable is non-zero, the tone table contents
 * for the tone_index are updated to the frequencies and gains defined.  It
 * should be noted that DTMF tones cannot be reassigned, so if DTMF tone
-* table indexs are used in a cadence the frequency and gain variables will
+* table indexes are used in a cadence the frequency and gain variables will
 * be ignored.
 *
 * If the array elements contain frequency parameters the driver will
diff -ru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	2006-10-14 20:32:25.000000000 -0400
+++ b/include/linux/reiserfs_fs_sb.h	2006-10-14 21:25:46.000000000 -0400
@@ -429,7 +429,7 @@
 /* -o hash={tea, rupasov, r5, detect} is meant for properly mounting 
 ** reiserfs disks from 3.5.19 or earlier.  99% of the time, this option
 ** is not required.  If the normal autodection code can't determine which
-** hash to use (because both hases had the same value for a file)
+** hash to use (because both hashes had the same value for a file)
 ** use this option to force a specific hash.  It won't allow you to override
 ** the existing hash on the FS, so if you have a tea hash disk, and mount
 ** with -o hash=rupasov, the mount will fail.
diff -ru a/net/wanrouter/af_wanpipe.c b/net/wanrouter/af_wanpipe.c
--- a/net/wanrouter/af_wanpipe.c	2006-09-19 23:42:06.000000000 -0400
+++ b/net/wanrouter/af_wanpipe.c	2006-10-14 21:04:45.000000000 -0400
@@ -13,7 +13,7 @@
 * Due Credit:
 *               Wanpipe socket layer is based on Packet and 
 *               the X25 socket layers. The above sockets were 
-*               used for the specific use of Sangoma Technoloiges 
+*               used for the specific use of Sangoma Technologies 
 *               API programs. 
 *               Packet socket Authors: Ross Biro, Fred N. van Kempen and 
 *                                      Alan Cox.
@@ -23,7 +23,7 @@
 * Apr 25, 2000  Nenad Corbic     o Added the ability to send zero length packets.
 * Mar 13, 2000  Nenad Corbic	 o Added a tx buffer check via ioctl call.
 * Mar 06, 2000  Nenad Corbic     o Fixed the corrupt sock lcn problem.
-*                                  Server and client applicaton can run
+*                                  Server and client application can run
 *                                  simultaneously without conflicts.
 * Feb 29, 2000  Nenad Corbic     o Added support for PVC protocols, such as
 *                                  CHDLC, Frame Relay and HDLC API.
diff -ru a/net/wanrouter/wanmain.c b/net/wanrouter/wanmain.c
--- a/net/wanrouter/wanmain.c	2006-09-19 23:42:06.000000000 -0400
+++ b/net/wanrouter/wanmain.c	2006-10-14 20:59:49.000000000 -0400
@@ -3,7 +3,7 @@
 *
 *		This module is completely hardware-independent and provides
 *		the following common services for the WAN Link Drivers:
-*		 o WAN device managenment (registering, unregistering)
+*		 o WAN device management (registering, unregistering)
 *		 o Network interface management
 *		 o Physical connection management (dial-up, incoming calls)
 *		 o Logical connection management (switched virtual circuits)
diff -ru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	2006-10-14 20:32:27.000000000 -0400
+++ b/sound/oss/cs46xx.c	2006-10-14 21:12:49.000000000 -0400
@@ -779,7 +779,7 @@
 		rate = 48000 / 9;
 
 	/*
-	 *  We can not capture at at rate greater than the Input Rate (48000).
+	 *  We cannot capture at at rate greater than the Input Rate (48000).
 	 *  Return an error if an attempt is made to stray outside that limit.
 	 */
 	if (rate > 48000)
@@ -4754,8 +4754,8 @@
 	mdelay(5 * cs_laptop_wait);		/* Shouldnt be needed ?? */
 	
 /*
-* If we are resuming under 2.2.x then we can not schedule a timeout.
-* so, just spin the CPU.
+* If we are resuming under 2.2.x then we cannot schedule a timeout,
+* so just spin the CPU.
 */
 	if (card->pm.flags & CS46XX_PM_IDLE) {
 	/*

