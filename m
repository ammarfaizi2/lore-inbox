Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSFKEEV>; Tue, 11 Jun 2002 00:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFKEEU>; Tue, 11 Jun 2002 00:04:20 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:47591 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316739AbSFKEER>; Tue, 11 Jun 2002 00:04:17 -0400
Date: Mon, 10 Jun 2002 22:03:55 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: David Ford <david+cert@blue-labs.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Double quote patches part two: drivers 2/2
Message-ID: <Pine.LNX.4.44.0206102156180.20111-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the rest of the malformed double quotes in the drivers dir.

Index: thunder-2.5/drivers/net/wireless/airo.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/wireless/airo.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/wireless/airo.c	10 Jun 2002 15:13:41 -0000	1.1
+++ thunder-2.5/drivers/net/wireless/airo.c	11 Jun 2002 03:22:17 -0000	1.2
@@ -224,9 +224,9 @@ static int airo_perm = 0555;
 static int proc_perm = 0644;
 
 MODULE_AUTHOR("Benjamin Reed");
-MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet \
-                   cards.  Direct support for ISA/PCI cards and support \
-		   for PCMCIA when used with airo_cs.");
+MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet "
+                   "cards.  Direct support for ISA/PCI cards and support "
+		   "for PCMCIA when used with airo_cs.");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_SUPPORTED_DEVICE("Aironet 4500, 4800 and Cisco 340");
 MODULE_PARM(io,"1-4i");
@@ -235,18 +235,18 @@ MODULE_PARM(basic_rate,"i");
 MODULE_PARM(rates,"1-8i");
 MODULE_PARM(ssids,"1-3s");
 MODULE_PARM(auto_wep,"i");
-MODULE_PARM_DESC(auto_wep, "If non-zero, the driver will keep looping through \
-the authentication options until an association is made.  The value of \
-auto_wep is number of the wep keys to check.  A value of 2 will try using \
-the key at index 0 and index 1.");
+MODULE_PARM_DESC(auto_wep, "If non-zero, the driver will keep looping through "
+"the authentication options until an association is made.  The value of "
+"auto_wep is number of the wep keys to check.  A value of 2 will try using "
+"the key at index 0 and index 1.");
 MODULE_PARM(aux_bap,"i");
-MODULE_PARM_DESC(aux_bap, "If non-zero, the driver will switch into a mode \
-than seems to work better for older cards with some older buses.  Before \
-switching it checks that the switch is needed.");
+MODULE_PARM_DESC(aux_bap, "If non-zero, the driver will switch into a mode "
+"than seems to work better for older cards with some older buses.  Before "
+"switching it checks that the switch is needed.");
 MODULE_PARM(maxencrypt, "i");
-MODULE_PARM_DESC(maxencrypt, "The maximum speed that the card can do \
-encryption.  Units are in 512kbs.  Zero (default) means there is no limit. \
-Older cards used to be limited to 2mbs (4).");
+MODULE_PARM_DESC(maxencrypt, "The maximum speed that the card can do "
+"encryption.  Units are in 512kbs.  Zero (default) means there is no limit. "
+"Older cards used to be limited to 2mbs (4).");
 MODULE_PARM(adhoc, "i");
 MODULE_PARM_DESC(adhoc, "If non-zero, the card will start in adhoc mode.");
 MODULE_PARM(probe, "i");
Index: thunder-2.5/drivers/net/wireless/airo_cs.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/wireless/airo_cs.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/wireless/airo_cs.c	10 Jun 2002 15:13:42 -0000	1.1
+++ thunder-2.5/drivers/net/wireless/airo_cs.c	11 Jun 2002 03:24:20 -0000	1.2
@@ -72,9 +72,9 @@ static u_int irq_mask = 0xdeb8;
 static int irq_list[4] = { -1 };
 
 MODULE_AUTHOR("Benjamin Reed");
-MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet \
-                   cards.  This is the module that links the PCMCIA card \
-		   with the airo module.");
+MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet "
+                   "cards.  This is the module that links the PCMCIA card "
+		   "with the airo module.");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_SUPPORTED_DEVICE("Aironet 4500, 4800 and Cisco 340 PCMCIA cards");
 MODULE_PARM(irq_mask, "i");
Index: thunder-2.5/drivers/net/wireless/orinoco.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/wireless/orinoco.c,v
retrieving revision 1.1
retrieving revision 1.2.1.1
diff -u -3 -p -r1.1 -r1.2.1.1
--- thunder-2.5/drivers/net/wireless/orinoco.c	10 Jun 2002 15:13:43 -0000	1.1
+++ thunder-2.5/drivers/net/wireless/orinoco.c	11 Jun 2002 03:28:34 -0000	1.2.1.1
@@ -650,8 +650,8 @@ orinoco_reset(struct orinoco_private *pr
 			goto out;
 		if((strlen(priv->desired_essid) == 0) && (priv->allow_ibss)
 		   && (!priv->has_ibss_any)) {
-			printk(KERN_WARNING "%s: This firmware requires an \
-ESSID in IBSS-Ad-Hoc mode.\n", dev->name);
+			printk(KERN_WARNING "%s: This firmware requires an "
+			       "ESSID in IBSS-Ad-Hoc mode.\n", dev->name);
 			/* With wvlan_cs, in this case, we would crash.
 			 * hopefully, this driver will behave better...
 			 * Jean II */
@@ -1147,10 +1147,12 @@ void orinoco_interrupt(int irq, void * d
 
 	evstat = hermes_read_regn(hw, EVSTAT);
 	events = evstat & hw->inten;
-	
-/*  	if (! events) { */
-/*  		printk(KERN_WARNING "%s: Null event\n", dev->name); */
-/*  	} */
+
+/*
+ *  	if (! events) {
+ *  		printk(KERN_WARNING "%s: Null event\n", dev->name);
+ *  	}
+ */
 
 	if (jiffies != last_irq_jiffy)
 		loops_this_jiffy = 0;
@@ -1161,8 +1163,8 @@ void orinoco_interrupt(int irq, void * d
 		      count, evstat);
 		
 		if (++loops_this_jiffy > MAX_IRQLOOPS_PER_JIFFY) {
-			printk(KERN_CRIT "%s: IRQ handler is looping too \
-much! Shutting down.\n",
+			printk(KERN_CRIT "%s: IRQ handler is looping too "
+			       "much! Shutting down.\n",
 			       dev->name);
 			/* Perform an emergency shutdown */
 			clear_bit(ORINOCO_STATE_DOIRQ, &priv->state);
@@ -2631,8 +2633,9 @@ static int orinoco_ioctl_setfrag(struct 
 			priv->mwo_robust = 0;
 		else {
 			if (frq->fixed)
-				printk(KERN_WARNING "%s: Fixed fragmentation not \
-supported on this firmware. Using MWO robust instead.\n", dev->name);
+				printk(KERN_WARNING "%s: Fixed fragmentation "
+				       "not supported on this firmware. Using"
+				       " MWO robust instead.\n", dev->name);
 			priv->mwo_robust = 1;
 		}
 	} else {
Index: thunder-2.5/drivers/scsi/aic7xxx/aicasm/aicasm.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/scsi/aic7xxx/aicasm/aicasm.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/scsi/aic7xxx/aicasm/aicasm.c	10 Jun 2002 15:15:58 -0000	1.1
+++ thunder-2.5/drivers/scsi/aic7xxx/aicasm/aicasm.c	11 Jun 2002 03:37:05 -0000	1.2
@@ -280,9 +280,9 @@ usage()
 {
 
 	(void)fprintf(stderr,
-"usage: %-16s [-nostdinc] [-I-] [-I directory] [-o output_file]
-			[-r register_output_file] [-l program_list_file]
-			input_file\n",
+"usage: %-16s [-nostdinc] [-I-] [-I directory] [-o output_file]\n"
+"			[-r register_output_file] [-l program_list_file]\n"
+"			input_file\n",
 			appname);
 	exit(EX_USAGE);
 }
@@ -362,26 +362,21 @@ output_code()
 	     cur_node != NULL;
 	     cur_node = SLIST_NEXT(cur_node,links)) {
 		fprintf(ofile,
-"static int ahc_patch%d_func(struct ahc_softc *ahc);
-
-static int
-ahc_patch%d_func(struct ahc_softc *ahc)
-{
-	return (%s);
-}\n\n",
+			"static int ahc_patch%d_func(struct ahc_softc *ahc);\n"
+			"\nstatic int ahc_patch%d_func(struct ahc_softc *ahc)\n"
+			"{\n\treturn (%s);\n}\n\n",
 			cur_node->symbol->info.condinfo->func_num,
 			cur_node->symbol->info.condinfo->func_num,
 			cur_node->symbol->name);
 	}
 
-	fprintf(ofile,
-"typedef int patch_func_t (struct ahc_softc *);
-struct patch {
-	patch_func_t	*patch_func;
-	uint32_t	begin	   :10,
-			skip_instr :10,
-			skip_patch :12;
-} patches[] = {\n");
+	fprintf(ofile, "typedef int patch_func_t (struct ahc_softc *);\n"
+		"struct patch {\n"
+		"	patch_func_t	*patch_func;\n"
+		"	uint32_t	begin	   :10,\n"
+		"			skip_instr :10,\n"
+		"			skip_patch :12;\n"
+		"} patches[] = {\n");
 
 	for(cur_patch = STAILQ_FIRST(&patches);
 	    cur_patch != NULL;
@@ -394,11 +389,10 @@ struct patch {
 
 	fprintf(ofile, "\n};\n");
 
-	fprintf(ofile,
-"struct cs {
-	u_int16_t	begin;
-	u_int16_t	end;
-} critical_sections[] = {\n");
+	fprintf(ofile, "struct cs {\n"
+		"	u_int16_t	begin;\n"
+		"	u_int16_t	end;\n"
+		"} critical_sections[] = {\n");
 
 	for(cs = TAILQ_FIRST(&cs_tailq);
 	    cs != NULL;
@@ -411,8 +405,8 @@ struct patch {
 	fprintf(ofile, "\n};\n");
 
 	fprintf(ofile,
-"const int num_critical_sections = sizeof(critical_sections)
-				 / sizeof(*critical_sections);\n");
+		"const int num_critical_sections = sizeof(critical_sections)\n"
+		"\t\t\t\t / sizeof(*critical_sections);\n");
 
 	fprintf(stderr, "%s: %d instructions used\n", appname, instrcount);
 }
Index: thunder-2.5/drivers/scsi/aic7xxx/aic7xxx_linux.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/scsi/aic7xxx/aic7xxx_linux.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/scsi/aic7xxx/aic7xxx_linux.c	10 Jun 2002 15:15:56 -0000	1.1
+++ thunder-2.5/drivers/scsi/aic7xxx/aic7xxx_linux.c	11 Jun 2002 03:40:15 -0000	1.2
@@ -398,26 +398,26 @@ MODULE_DESCRIPTION("Adaptec Aic77XX/78XX
 MODULE_LICENSE("Dual BSD/GPL");
 #endif
 MODULE_PARM(aic7xxx, "s");
-MODULE_PARM_DESC(aic7xxx, "period delimited, options string.
-	verbose			Enable verbose/diagnostic logging
-	no_probe		Disable EISA/VLB controller probing
-	no_reset		Supress initial bus resets
-	extended		Enable extended geometry on all controllers
-	periodic_otag		Send an ordered tagged transaction periodically
-				to prevent tag starvation.  This may be
-				required by some older disk drives/RAID arrays. 
-	reverse_scan		Sort PCI devices highest Bus/Slot to lowest
-	tag_info:<tag_str>	Set per-target tag depth
-	seltime:<int>		Selection Timeout(0/256ms,1/128ms,2/64ms,3/32ms)
-
-	Sample /etc/modules.conf line:
-		Enable verbose logging
-		Disable EISA/VLB probing
-		Set tag depth on Controller 2/Target 2 to 10 tags
-		Shorten the selection timeout to 128ms from its default of 256
-
-	options aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'
-");
+MODULE_PARM_DESC(aic7xxx, "period delimited, options string.\n"
+"	verbose			Enable verbose/diagnostic logging\n"
+"	no_probe		Disable EISA/VLB controller probing\n"
+"	no_reset		Supress initial bus resets\n"
+"	extended		Enable extended geometry on all controllers\n"
+"	periodic_otag		Send an ordered tagged transaction periodically\n"
+"				to prevent tag starvation.  This may be\n"
+"				required by some older disk drives/RAID arrays. \n"
+"	reverse_scan		Sort PCI devices highest Bus/Slot to lowest\n"
+"	tag_info:<tag_str>	Set per-target tag depth\n"
+"	seltime:<int>		Selection Timeout(0/256ms,1/128ms,2/64ms,3/32ms)\n"
+"\n"
+"	Sample /etc/modules.conf line:\n"
+"		Enable verbose logging\n"
+"		Disable EISA/VLB probing\n"
+"		Set tag depth on Controller 2/Target 2 to 10 tags\n"
+"		Shorten the selection timeout to 128ms from its default of 256\n"
+"\n"
+"	options aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'\n"
+"\n");
 #endif
 
 static void ahc_linux_handle_scsi_status(struct ahc_softc *,
Index: thunder-2.5/drivers/scsi/53c700.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/scsi/53c700.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/scsi/53c700.c	10 Jun 2002 15:15:16 -0000	1.1
+++ thunder-2.5/drivers/scsi/53c700.c	11 Jun 2002 03:42:43 -0000	1.2
@@ -1794,9 +1794,9 @@ NCR_700_proc_directory_info(char *proc_b
 	}
 	hostdata = (struct NCR_700_Host_Parameters *)host->hostdata[0];
 	len += sprintf(&buf[len], "Total commands outstanding: %d\n", hostdata->command_slot_count);
-	len += sprintf(&buf[len],"\
-Target	Depth  Active  Next Tag\n\
-======	=====  ======  ========\n");
+	len += sprintf(&buf[len],
+		       "Target	Depth  Active  Next Tag\n"
+		       "======	=====  ======  ========\n");
 	for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next) {
 		len += sprintf(&buf[len]," %2d:%2d   %4d    %4d      %4d\n", SDp->id, SDp->lun, SDp->queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
 	}
Index: thunder-2.5/drivers/scsi/BusLogic.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/scsi/BusLogic.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/scsi/BusLogic.c	10 Jun 2002 15:15:49 -0000	1.1
+++ thunder-2.5/drivers/scsi/BusLogic.c	11 Jun 2002 03:47:55 -0000	1.2
@@ -4239,16 +4239,15 @@ int BusLogic_ProcDirectoryInfo(char *Pro
     }
   Buffer = HostAdapter->MessageBuffer;
   Length = HostAdapter->MessageBufferLength;
-  Length += sprintf(&Buffer[Length], "\n\
-Current Driver Queue Depth:	%d\n\
-Currently Allocated CCBs:	%d\n",
+  Length += sprintf(&Buffer[Length], "\n"
+		    "Current Driver Queue Depth:	%d\n"
+		    "Currently Allocated CCBs:	%d\n",
 		    HostAdapter->DriverQueueDepth,
 		    HostAdapter->AllocatedCCBs);
-  Length += sprintf(&Buffer[Length], "\n\n\
-			   DATA TRANSFER STATISTICS\n\
-\n\
-Target	Tagged Queuing	Queue Depth  Active  Attempted	Completed\n\
-======	==============	===========  ======  =========	=========\n");
+  Length += sprintf(&Buffer[Length], "\n\n"
+		    "			   DATA TRANSFER STATISTICS\n\n"
+		    "Target	Tagged Queuing	Queue Depth  Active  Attempted	Completed\n"
+		    "======	==============	===========  ======  =========	=========\n");
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     {
       BusLogic_TargetFlags_T *TargetFlags = &HostAdapter->TargetFlags[TargetID];
@@ -4268,9 +4267,9 @@ Target	Tagged Queuing	Queue Depth  Activ
 			TargetStatistics[TargetID].CommandsAttempted,
 			TargetStatistics[TargetID].CommandsCompleted);
     }
-  Length += sprintf(&Buffer[Length], "\n\
-Target  Read Commands  Write Commands   Total Bytes Read    Total Bytes Written\n\
-======  =============  ==============  ===================  ===================\n");
+  Length += sprintf(&Buffer[Length], "\n"
+		    "Target  Read Commands  Write Commands   Total Bytes Read    Total Bytes Written\n"
+		    "======  =============  ==============  ===================  ===================\n");
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     {
       BusLogic_TargetFlags_T *TargetFlags = &HostAdapter->TargetFlags[TargetID];
@@ -4298,9 +4297,9 @@ Target  Read Commands  Write Commands   
 	  sprintf(&Buffer[Length], "	     %9u\n",
 		  TargetStatistics[TargetID].TotalBytesWritten.Units);
     }
-  Length += sprintf(&Buffer[Length], "\n\
-Target  Command    0-1KB      1-2KB      2-4KB      4-8KB     8-16KB\n\
-======  =======  =========  =========  =========  =========  =========\n");
+  Length += sprintf(&Buffer[Length], "\n"
+		    "Target  Command    0-1KB      1-2KB      2-4KB      4-8KB     8-16KB\n"
+		    "======  =======  =========  =========  =========  =========  =========\n");
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     {
       BusLogic_TargetFlags_T *TargetFlags = &HostAdapter->TargetFlags[TargetID];
@@ -4322,9 +4321,9 @@ Target  Command    0-1KB      1-2KB     
 		TargetStatistics[TargetID].WriteCommandSizeBuckets[3],
 		TargetStatistics[TargetID].WriteCommandSizeBuckets[4]);
     }
-  Length += sprintf(&Buffer[Length], "\n\
-Target  Command   16-32KB    32-64KB   64-128KB   128-256KB   256KB+\n\
-======  =======  =========  =========  =========  =========  =========\n");
+  Length += sprintf(&Buffer[Length], "\n"
+		    "Target  Command   16-32KB    32-64KB   64-128KB   128-256KB   256KB+\n"
+		    "======  =======  =========  =========  =========  =========  =========\n");
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     {
       BusLogic_TargetFlags_T *TargetFlags = &HostAdapter->TargetFlags[TargetID];
@@ -4346,20 +4345,20 @@ Target  Command   16-32KB    32-64KB   6
 		TargetStatistics[TargetID].WriteCommandSizeBuckets[8],
 		TargetStatistics[TargetID].WriteCommandSizeBuckets[9]);
     }
-  Length += sprintf(&Buffer[Length], "\n\n\
-			   ERROR RECOVERY STATISTICS\n\
-\n\
-	  Command Aborts      Bus Device Resets	  Host Adapter Resets\n\
-Target	Requested Completed  Requested Completed  Requested Completed\n\
-  ID	\\\\\\\\ Attempted ////  \\\\\\\\ Attempted ////  \\\\\\\\ Attempted ////\n\
-======	 ===== ===== =====    ===== ===== =====	   ===== ===== =====\n");
+  Length += sprintf(&Buffer[Length], "\n\n"
+		    "			   ERROR RECOVERY STATISTICS\n\n"
+		    "	  Command Aborts      Bus Device Resets	  Host Adapter Resets\n"
+		    "Target	Requested Completed  Requested Completed  Requested Completed\n"
+		    "  ID	\\\\\\\\ Attempted ////  \\\\\\\\ Attempted ////  \\\\\\\\ Attempted ////\n"
+		    "======	 ===== ===== =====    ===== ===== =====	   ===== ===== =====\n");
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     {
       BusLogic_TargetFlags_T *TargetFlags = &HostAdapter->TargetFlags[TargetID];
       if (!TargetFlags->TargetExists) continue;
       Length +=
-	sprintf(&Buffer[Length], "\
-  %2d	 %5d %5d %5d    %5d %5d %5d	   %5d %5d %5d\n", TargetID,
+	sprintf(&Buffer[Length],
+		"  %2d	 %5d %5d %5d    %5d %5d %5d	   %5d %5d %5d\n",
+		TargetID,
 		TargetStatistics[TargetID].CommandAbortsRequested,
 		TargetStatistics[TargetID].CommandAbortsAttempted,
 		TargetStatistics[TargetID].CommandAbortsCompleted,
Index: thunder-2.5/drivers/usb/media/ov511.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/usb/media/ov511.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/usb/media/ov511.c	10 Jun 2002 15:16:13 -0000	1.1
+++ thunder-2.5/drivers/usb/media/ov511.c	11 Jun 2002 03:52:16 -0000	1.2
@@ -63,9 +63,9 @@
  */
 #define DRIVER_VERSION "v1.60a for Linux 2.5"
 #define EMAIL "mmcclell@bigfoot.com"
-#define DRIVER_AUTHOR "Mark McClelland <mmcclell@bigfoot.com> & Bret Wallach \
-	& Orion Sky Lawlor <olawlor@acm.org> & Kevin Moore & Charl P. Botha \
-	<cpbotha@ieee.org> & Claudio Matsuoka <claudio@conectiva.com>"
+#define DRIVER_AUTHOR "Mark McClelland <mmcclell@bigfoot.com> & Bret Wallach "
+	"& Orion Sky Lawlor <olawlor@acm.org> & Kevin Moore & Charl P. Botha "
+	"<cpbotha@ieee.org> & Claudio Matsuoka <claudio@conectiva.com>"
 #define DRIVER_DESC "ov511 USB Camera Driver"
 
 #define OV511_I2C_RETRIES 3
Index: thunder-2.5/drivers/zorro/gen-devlist.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/zorro/gen-devlist.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/zorro/gen-devlist.c	10 Jun 2002 15:17:21 -0000	1.1
+++ thunder-2.5/drivers/zorro/gen-devlist.c	11 Jun 2002 03:53:59 -0000	1.2
@@ -95,11 +95,10 @@ main(void)
 			return 1;
 		}
 	}
-	fputs("ENDMANUF()\n\
-\n\
-#undef MANUF\n\
-#undef PRODUCT\n\
-#undef ENDMANUF\n", devf);
+	fputs("ENDMANUF()\n\n"
+	      "#undef MANUF\n"
+	      "#undef PRODUCT\n"
+	      "#undef ENDMANUF\n", devf);
 
 	fclose(devf);
 

-- 
Lightweight patch manager using pine. If you have any objections, tell me.


