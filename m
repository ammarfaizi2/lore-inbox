Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWJXOm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWJXOm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWJXOm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:42:29 -0400
Received: from server6.greatnet.de ([83.133.96.26]:32660 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964897AbWJXOm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:42:28 -0400
Message-ID: <453E267F.9040403@nachtwindheim.de>
Date: Tue, 24 Oct 2006 16:43:11 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] scsi: whitespace cleanup in the dpt driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some trailing whitespaces and some replace whitespaces with tabs.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 dpti_i2o.h   |   48 ++++++++++++++++++++++++------------------------
 dpti_ioctl.h |    2 +-
 dptsig.h     |    4 ++--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/dpt/dpti_i2o.h b/drivers/scsi/dpt/dpti_i2o.h
index b3fa7ed..49d44fe 100644
--- a/drivers/scsi/dpt/dpti_i2o.h
+++ b/drivers/scsi/dpt/dpti_i2o.h
@@ -31,7 +31,7 @@ #include <asm/atomic.h>
  *	Tunable parameters first
  */
 
-/* How many different OSM's are we allowing */ 
+/* How many different OSM's are we allowing */
 #define MAX_I2O_MODULES		64
 
 #define I2O_EVT_CAPABILITY_OTHER		0x01
@@ -63,7 +63,7 @@ struct i2o_message
 	u16	size;
 	u32	target_tid:12;
 	u32	init_tid:12;
-	u32	function:8;	
+	u32	function:8;
 	u32	initiator_context;
 	/* List follows */
 };
@@ -77,7 +77,7 @@ struct i2o_device
 
 	char dev_name[8];		/* linux /dev name if available */
 	i2o_lct_entry lct_data;/* Device LCT information */
-	u32 flags;		
+	u32 flags;
 	struct proc_dir_entry* proc_entry;	/* /proc dir */
 	struct adpt_device *owner;
 	struct _adpt_hba *controller;	/* Controlling IOP */
@@ -86,7 +86,7 @@ struct i2o_device
 /*
  *	Each I2O controller has one of these objects
  */
- 
+
 struct i2o_controller
 {
 	char name[16];
@@ -111,9 +111,9 @@ struct i2o_sys_tbl_entry
 	u32	iop_id:12;
 	u32	reserved2:20;
 	u16	seg_num:12;
-	u16 	i2o_version:4;
-	u8 	iop_state;
-	u8 	msg_type;
+	u16	i2o_version:4;
+	u8	iop_state;
+	u8	msg_type;
 	u16	frame_size;
 	u16	reserved3;
 	u32	last_changed;
@@ -124,14 +124,14 @@ struct i2o_sys_tbl_entry
 
 struct i2o_sys_tbl
 {
-	u8 	num_entries;
-	u8 	version;
-	u16 	reserved1;
+	u8	num_entries;
+	u8	version;
+	u16	reserved1;
 	u32	change_ind;
 	u32	reserved2;
 	u32	reserved3;
 	struct i2o_sys_tbl_entry iops[0];
-};	
+};
 
 /*
  *	I2O classes / subclasses
@@ -146,7 +146,7 @@ #define    I2O_CLASS_VERSION_11         
 /*  Class code names
  *  (from v1.5 Table 6-1 Class Code Assignments.)
  */
- 
+
 #define    I2O_CLASS_EXECUTIVE                         0x000
 #define    I2O_CLASS_DDM                               0x001
 #define    I2O_CLASS_RANDOM_BLOCK_STORAGE              0x010
@@ -166,7 +166,7 @@ #define    I2O_CLASS_PEER_TRANSPORT     
 
 /*  Rest of 0x092 - 0x09f reserved for peer-to-peer classes
  */
- 
+
 #define    I2O_CLASS_MATCH_ANYCLASS                    0xffffffff
 
 /*  Subclasses
@@ -175,7 +175,7 @@ #define    I2O_CLASS_MATCH_ANYCLASS     
 #define    I2O_SUBCLASS_i960                           0x001
 #define    I2O_SUBCLASS_HDM                            0x020
 #define    I2O_SUBCLASS_ISM                            0x021
- 
+
 /* Operation functions */
 
 #define I2O_PARAMS_FIELD_GET	0x0001
@@ -219,7 +219,7 @@ #define TRL_MULTIPLE_FIXED_LENGTH	0x80
 /*
  *	Messaging API values
  */
- 
+
 #define	I2O_CMD_ADAPTER_ASSIGN		0xB3
 #define	I2O_CMD_ADAPTER_READ		0xB2
 #define	I2O_CMD_ADAPTER_RELEASE		0xB5
@@ -284,16 +284,16 @@ #define I2O_CMD_BLOCK_MEJECT		0x43
 #define I2O_PRIVATE_MSG			0xFF
 
 /*
- *	Init Outbound Q status 
+ *	Init Outbound Q status
  */
- 
+
 #define I2O_CMD_OUTBOUND_INIT_IN_PROGRESS	0x01
 #define I2O_CMD_OUTBOUND_INIT_REJECTED		0x02
 #define I2O_CMD_OUTBOUND_INIT_FAILED		0x03
 #define I2O_CMD_OUTBOUND_INIT_COMPLETE		0x04
 
 /*
- *	I2O Get Status State values 
+ *	I2O Get Status State values
  */
 
 #define	ADAPTER_STATE_INITIALIZING		0x01
@@ -303,7 +303,7 @@ #define ADAPTER_STATE_READY			0x05
 #define	ADAPTER_STATE_OPERATIONAL		0x08
 #define	ADAPTER_STATE_FAILED			0x10
 #define	ADAPTER_STATE_FAULTED			0x11
-	
+
 /* I2O API function return values */
 
 #define I2O_RTN_NO_ERROR			0
@@ -321,9 +321,9 @@ #define	I2O_RTN_NO_LINK_SPEED			11
 
 /* Reply message status defines for all messages */
 
-#define I2O_REPLY_STATUS_SUCCESS                    	0x00
-#define I2O_REPLY_STATUS_ABORT_DIRTY                	0x01
-#define I2O_REPLY_STATUS_ABORT_NO_DATA_TRANSFER     	0x02
+#define I2O_REPLY_STATUS_SUCCESS			0x00
+#define I2O_REPLY_STATUS_ABORT_DIRTY			0x01
+#define I2O_REPLY_STATUS_ABORT_NO_DATA_TRANSFER		0x02
 #define	I2O_REPLY_STATUS_ABORT_PARTIAL_TRANSFER		0x03
 #define	I2O_REPLY_STATUS_ERROR_DIRTY			0x04
 #define	I2O_REPLY_STATUS_ERROR_NO_DATA_TRANSFER		0x05
@@ -338,7 +338,7 @@ #define	I2O_REPLY_STATUS_PROGRESS_REPORT
 
 #define I2O_PARAMS_STATUS_SUCCESS		0x00
 #define I2O_PARAMS_STATUS_BAD_KEY_ABORT		0x01
-#define I2O_PARAMS_STATUS_BAD_KEY_CONTINUE   	0x02
+#define I2O_PARAMS_STATUS_BAD_KEY_CONTINUE	0x02
 #define I2O_PARAMS_STATUS_BUFFER_FULL		0x03
 #define I2O_PARAMS_STATUS_BUFFER_TOO_SMALL	0x04
 #define I2O_PARAMS_STATUS_FIELD_UNREADABLE	0x05
@@ -390,7 +390,7 @@ #define	I2O_CLAIM_PRIMARY					0x01000000
 #define	I2O_CLAIM_MANAGEMENT					0x02000000
 #define	I2O_CLAIM_AUTHORIZED					0x03000000
 #define	I2O_CLAIM_SECONDARY					0x04000000
- 
+
 /* Message header defines for VersionOffset */
 #define I2OVER15	0x0001
 #define I2OVER20	0x0002
diff --git a/drivers/scsi/dpt/dpti_ioctl.h b/drivers/scsi/dpt/dpti_ioctl.h
index 82d2486..cc784e8 100644
--- a/drivers/scsi/dpt/dpti_ioctl.h
+++ b/drivers/scsi/dpt/dpti_ioctl.h
@@ -99,7 +99,7 @@ typedef struct {
 	uCHAR    eataVersion;      /* EATA Version                    */
 	uLONG    cpLength;         /* EATA Command Packet Length      */
 	uLONG    spLength;         /* EATA Status Packet Length       */
-	uCHAR    drqNum;           /* DRQ Index (0,5,6,7)             */ 
+	uCHAR    drqNum;           /* DRQ Index (0,5,6,7)             */
 	uCHAR    flag1;            /* EATA Flags 1 (Byte 9)           */
 	uCHAR    flag2;            /* EATA Flags 2 (Byte 30)          */
 } CtrlInfo;
diff --git a/drivers/scsi/dpt/dptsig.h b/drivers/scsi/dpt/dptsig.h
index 4bf4477..94bc894 100644
--- a/drivers/scsi/dpt/dptsig.h
+++ b/drivers/scsi/dpt/dptsig.h
@@ -145,8 +145,8 @@ #define FT_HELPFILE     11      /* Help 
 #define FT_LOGGER       12      /* Event Logger */
 #define FT_INSTALL      13      /* An Install Program */
 #define FT_LIBRARY      14      /* Storage Manager Real-Mode Calls */
-#define FT_RESOURCE 	15 	/* Storage Manager Resource File */
-#define FT_MODEM_DB  	16  	/* Storage Manager Modem Database */
+#define FT_RESOURCE	15	/* Storage Manager Resource File */
+#define FT_MODEM_DB	16	/* Storage Manager Modem Database */
 
 /* Filetype flags - sigBYTE dsFiletypeFlags;    FLAG BITS */
 /* ------------------------------------------------------------------ */


