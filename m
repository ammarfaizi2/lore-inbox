Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSGXSuc>; Wed, 24 Jul 2002 14:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGXSuc>; Wed, 24 Jul 2002 14:50:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:25095 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317508AbSGXSss>;
	Wed, 24 Jul 2002 14:48:48 -0400
Date: Wed, 24 Jul 2002 11:51:48 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] agpgart changes for 2.5.27
Message-ID: <20020724185147.GB10897@kroah.com>
References: <20020724185105.GA10897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724185105.GA10897@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 17:49:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.640   -> 1.641  
#	drivers/char/agp/frontend.c	1.14    -> 1.15   
#	drivers/char/agp/agp.c	1.37    -> 1.38   
#	drivers/char/agp/i460-agp.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	rusty@rustcorp.com.au	1.641
# [PATCH] AGP designated initializer update.
# 
# The old form of designated initializers are obsolete: we need to
# replace them with the ISO C forms before 2.6.  Gcc has always supported
# both forms anyway.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agp.c b/drivers/char/agp/agp.c
--- a/drivers/char/agp/agp.c	Wed Jul 24 11:46:05 2002
+++ b/drivers/char/agp/agp.c	Wed Jul 24 11:46:05 2002
@@ -751,396 +751,396 @@
 
 #ifdef CONFIG_AGP_ALI
 	{
-		device_id:	PCI_DEVICE_ID_AL_M1541_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1541,
-		vendor_name:	"Ali",
-		chipset_name:	"M1541",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1621_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1621,
-		vendor_name:	"Ali",
-		chipset_name:	"M1621",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1631_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1631,
-		vendor_name:	"Ali",
-		chipset_name:	"M1631",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1632_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1632,
-		vendor_name:	"Ali",
-		chipset_name:	"M1632",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1641_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1641,
-		vendor_name:	"Ali",
-		chipset_name:	"M1641",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1644_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1644,
-		vendor_name:	"Ali",
-		chipset_name:	"M1644",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1647_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1647,
-		vendor_name:	"Ali",
-		chipset_name:	"M1647",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AL_M1651_0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_M1651,
-		vendor_name:	"Ali",
-		chipset_name:	"M1651",
-		chipset_setup:	ali_generic_setup,
-	},
-	{
-		device_id:	0,
-		vendor_id:	PCI_VENDOR_ID_AL,
-		chipset:	ALI_GENERIC,
-		vendor_name:	"Ali",
-		chipset_name:	"Generic",
-		chipset_setup:	ali_generic_setup,
+		.device_id	= PCI_DEVICE_ID_AL_M1541_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1541,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1541",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1621_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1621,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1621",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1631_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1631,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1631",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1632_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1632,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1632",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1641_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1641,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1641",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1644_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1644,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1644",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1647_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1647,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1647",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AL_M1651_0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_M1651,
+		.vendor_name	= "Ali",
+		.chipset_name	= "M1651",
+		.chipset_setup	= ali_generic_setup,
+	},
+	{
+		.device_id	= 0,
+		.vendor_id	= PCI_VENDOR_ID_AL,
+		.chipset	= ALI_GENERIC,
+		.vendor_name	= "Ali",
+		.chipset_name	= "Generic",
+		.chipset_setup	= ali_generic_setup,
 	},
 #endif /* CONFIG_AGP_ALI */
 
 #ifdef CONFIG_AGP_AMD
 	{
-		device_id:	PCI_DEVICE_ID_AMD_IRONGATE_0,
-		vendor_id:	PCI_VENDOR_ID_AMD,
-		chipset:	AMD_IRONGATE,
-		vendor_name:	"AMD",
-		chipset_name:	"Irongate",
-		chipset_setup:	amd_irongate_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AMD_761_0,
-		vendor_id:	PCI_VENDOR_ID_AMD,
-		chipset:	AMD_761,
-		vendor_name:	"AMD",
-		chipset_name:	"761",
-		chipset_setup:	amd_irongate_setup,
-	},
-	{
-		device_id:	PCI_DEVICE_ID_AMD_762_0,
-		vendor_id:	PCI_VENDOR_ID_AMD,
-		chipset:	AMD_762,
-		vendor_name:	"AMD",
-		chipset_name:	"760MP",
-		chipset_setup:	amd_irongate_setup,
-	},
-	{
-		device_id:	0,
-		vendor_id:	PCI_VENDOR_ID_AMD,
-		chipset:	AMD_GENERIC,
-		vendor_name:	"AMD",
-		chipset_name:	"Generic",
-		chipset_setup:	amd_irongate_setup,
+		.device_id	= PCI_DEVICE_ID_AMD_IRONGATE_0,
+		.vendor_id	= PCI_VENDOR_ID_AMD,
+		.chipset	= AMD_IRONGATE,
+		.vendor_name	= "AMD",
+		.chipset_name	= "Irongate",
+		.chipset_setup	= amd_irongate_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AMD_761_0,
+		.vendor_id	= PCI_VENDOR_ID_AMD,
+		.chipset	= AMD_761,
+		.vendor_name	= "AMD",
+		.chipset_name	= "761",
+		.chipset_setup	= amd_irongate_setup,
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_AMD_762_0,
+		.vendor_id	= PCI_VENDOR_ID_AMD,
+		.chipset	= AMD_762,
+		.vendor_name	= "AMD",
+		.chipset_name	= "760MP",
+		.chipset_setup	= amd_irongate_setup,
+	},
+	{
+		.device_id	= 0,
+		.vendor_id	= PCI_VENDOR_ID_AMD,
+		.chipset	= AMD_GENERIC,
+		.vendor_name	= "AMD",
+		.chipset_name	= "Generic",
+		.chipset_setup	= amd_irongate_setup,
 	},
 #endif /* CONFIG_AGP_AMD */
 
 #ifdef CONFIG_AGP_INTEL
 	{
-		device_id:	PCI_DEVICE_ID_INTEL_82443LX_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_LX,
-		vendor_name:	"Intel",
-		chipset_name:	"440LX",
-		chipset_setup:	intel_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_82443BX_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_BX,
-		vendor_name:	"Intel",
-		chipset_name:	"440BX",
-		chipset_setup:	intel_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_82443GX_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_GX,
-		vendor_name:	"Intel",
-		chipset_name:	"440GX",
-		chipset_setup:	intel_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_815_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I815,
-		vendor_name:	"Intel",
-		chipset_name:	"i815",
-		chipset_setup:	intel_815_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_820_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I820,
-		vendor_name:	"Intel",
-		chipset_name:	"i820",
-		chipset_setup:	intel_820_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_820_UP_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I820,
-		vendor_name:	"Intel",
-		chipset_name:	"i820",
-		chipset_setup:	intel_820_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_830_M_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I830_M,
-		vendor_name:	"Intel",
-		chipset_name:	"i830M",
-		chipset_setup:	intel_830mp_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_845_G_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I845_G,
-		vendor_name:	"Intel",
-		chipset_name:	"i845G",
-		chipset_setup:	intel_830mp_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_840_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I840,
-		vendor_name:	"Intel",
-		chipset_name:	"i840",
-		chipset_setup:	intel_840_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_845_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I845,
-		vendor_name:	"Intel",
-		chipset_name:	"i845",
-		chipset_setup:	intel_845_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_850_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I850,
-		vendor_name:	"Intel",
-		chipset_name:	"i850",
-		chipset_setup:	intel_850_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_INTEL_860_0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_I860,
-		vendor_name:	"Intel",
-		chipset_name:	"i860",
-		chipset_setup:	intel_860_setup
-	},
-	{
-		device_id:	0,
-		vendor_id:	PCI_VENDOR_ID_INTEL,
-		chipset:	INTEL_GENERIC,
-		vendor_name:	"Intel",
-		chipset_name:	"Generic",
-		chipset_setup:	intel_generic_setup
+		.device_id	= PCI_DEVICE_ID_INTEL_82443LX_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_LX,
+		.vendor_name	= "Intel",
+		.chipset_name	= "440LX",
+		.chipset_setup	= intel_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82443BX_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_BX,
+		.vendor_name	= "Intel",
+		.chipset_name	= "440BX",
+		.chipset_setup	= intel_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82443GX_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_GX,
+		.vendor_name	= "Intel",
+		.chipset_name	= "440GX",
+		.chipset_setup	= intel_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_815_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I815,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i815",
+		.chipset_setup	= intel_815_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_820_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I820,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i820",
+		.chipset_setup	= intel_820_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_820_UP_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I820,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i820",
+		.chipset_setup	= intel_820_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_830_M_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I830_M,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i830M",
+		.chipset_setup	= intel_830mp_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_845_G_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I845_G,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i845G",
+		.chipset_setup	= intel_830mp_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_840_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I840,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i840",
+		.chipset_setup	= intel_840_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_845_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I845,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i845",
+		.chipset_setup	= intel_845_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_850_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I850,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i850",
+		.chipset_setup	= intel_850_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_INTEL_860_0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_I860,
+		.vendor_name	= "Intel",
+		.chipset_name	= "i860",
+		.chipset_setup	= intel_860_setup
+	},
+	{
+		.device_id	= 0,
+		.vendor_id	= PCI_VENDOR_ID_INTEL,
+		.chipset	= INTEL_GENERIC,
+		.vendor_name	= "Intel",
+		.chipset_name	= "Generic",
+		.chipset_setup	= intel_generic_setup
 	},
 
 #endif /* CONFIG_AGP_INTEL */
 
 #ifdef CONFIG_AGP_SIS
 	{
-		device_id:	PCI_DEVICE_ID_SI_740,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"740",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_650,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"650",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_645,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"645",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_735,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"735",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_745,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"745",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_730,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"730",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_630,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"630",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_540,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"540",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_620,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"620",
-		chipset_setup:	sis_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_SI_530,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"530",
-		chipset_setup:	sis_generic_setup
+		.device_id	= PCI_DEVICE_ID_SI_740,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "740",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_650,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "650",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_645,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "645",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_735,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "735",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_745,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "745",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_730,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "730",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_630,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "630",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_540,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "540",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_620,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "620",
+		.chipset_setup	= sis_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_SI_530,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "530",
+		.chipset_setup	= sis_generic_setup
 	},
         {
-		device_id:	PCI_DEVICE_ID_SI_550,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"550",
-		chipset_setup:	sis_generic_setup
+		.device_id	= PCI_DEVICE_ID_SI_550,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "550",
+		.chipset_setup	= sis_generic_setup
 	},
 	{
-		device_id:	0,
-		vendor_id:	PCI_VENDOR_ID_SI,
-		chipset:	SIS_GENERIC,
-		vendor_name:	"SiS",
-		chipset_name:	"Generic",
-		chipset_setup:	sis_generic_setup
+		.device_id	= 0,
+		.vendor_id	= PCI_VENDOR_ID_SI,
+		.chipset	= SIS_GENERIC,
+		.vendor_name	= "SiS",
+		.chipset_name	= "Generic",
+		.chipset_setup	= sis_generic_setup
 	},
 #endif /* CONFIG_AGP_SIS */
 
 #ifdef CONFIG_AGP_VIA
 	{
-		device_id:	PCI_DEVICE_ID_VIA_8501_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_MVP4,
-		vendor_name:	"Via",
-		chipset_name:	"MVP4",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_82C597_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_VP3,
-		vendor_name:	"Via",
-		chipset_name:	"VP3",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_82C598_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_MVP3,
-		vendor_name:	"Via",
-		chipset_name:	"MVP3",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_82C691_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_APOLLO_PRO,
-		vendor_name:	"Via",
-		chipset_name:	"Apollo Pro",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_8371_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_APOLLO_KX133,
-		vendor_name:	"Via",
-		chipset_name:	"Apollo Pro KX133",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_8363_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_APOLLO_KT133,
-		vendor_name:	"Via",
-		chipset_name:	"Apollo Pro KT133",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	PCI_DEVICE_ID_VIA_8367_0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_APOLLO_KT133,
-		vendor_name:	"Via",
-		chipset_name:	"Apollo Pro KT266",
-		chipset_setup:	via_generic_setup
-	},
-	{
-		device_id:	0,
-		vendor_id:	PCI_VENDOR_ID_VIA,
-		chipset:	VIA_GENERIC,
-		vendor_name:	"Via",
-		chipset_name:	"Generic",
-		chipset_setup:	via_generic_setup
+		.device_id	= PCI_DEVICE_ID_VIA_8501_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_MVP4,
+		.vendor_name	= "Via",
+		.chipset_name	= "MVP4",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C597_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_VP3,
+		.vendor_name	= "Via",
+		.chipset_name	= "VP3",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C598_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_MVP3,
+		.vendor_name	= "Via",
+		.chipset_name	= "MVP3",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_82C691_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_APOLLO_PRO,
+		.vendor_name	= "Via",
+		.chipset_name	= "Apollo Pro",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8371_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_APOLLO_KX133,
+		.vendor_name	= "Via",
+		.chipset_name	= "Apollo Pro KX133",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8363_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_APOLLO_KT133,
+		.vendor_name	= "Via",
+		.chipset_name	= "Apollo Pro KT133",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= PCI_DEVICE_ID_VIA_8367_0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_APOLLO_KT133,
+		.vendor_name	= "Via",
+		.chipset_name	= "Apollo Pro KT266",
+		.chipset_setup	= via_generic_setup
+	},
+	{
+		.device_id	= 0,
+		.vendor_id	= PCI_VENDOR_ID_VIA,
+		.chipset	= VIA_GENERIC,
+		.vendor_name	= "Via",
+		.chipset_name	= "Generic",
+		.chipset_setup	= via_generic_setup
 	},
 #endif /* CONFIG_AGP_VIA */
 
 #ifdef CONFIG_AGP_HP_ZX1
 	{
-		device_id:	PCI_DEVICE_ID_HP_ZX1_LBA,
-		vendor_id:	PCI_VENDOR_ID_HP,
-		chipset:	HP_ZX1,
-		vendor_name:	"HP",
-		chipset_name:	"ZX1",
-		chipset_setup:	hp_zx1_setup
+		.device_id	= PCI_DEVICE_ID_HP_ZX1_LBA,
+		.vendor_id	= PCI_VENDOR_ID_HP,
+		.chipset	= HP_ZX1,
+		.vendor_name	= "HP",
+		.chipset_name	= "ZX1",
+		.chipset_setup	= hp_zx1_setup
 	},
 #endif
 
@@ -1461,8 +1461,8 @@
 
 static struct agp_version agp_current_version =
 {
-	major:	AGPGART_VERSION_MAJOR,
-	minor:	AGPGART_VERSION_MINOR,
+	.major	= AGPGART_VERSION_MAJOR,
+	.minor	= AGPGART_VERSION_MINOR,
 };
 
 static int __init agp_backend_initialize(struct pci_dev *dev)
@@ -1614,12 +1614,12 @@
 
 static struct pci_device_id agp_pci_table[] __initdata = {
 	{
-	class:		(PCI_CLASS_BRIDGE_HOST << 8),
-	class_mask:	~0,
-	vendor:		PCI_ANY_ID,
-	device:		PCI_ANY_ID,
-	subvendor:	PCI_ANY_ID,
-	subdevice:	PCI_ANY_ID,
+	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
+	.class_mask	= ~0,
+	.vendor		= PCI_ANY_ID,
+	.device		= PCI_ANY_ID,
+	.subvendor	= PCI_ANY_ID,
+	.subdevice	= PCI_ANY_ID,
 	},
 	{ }
 };
@@ -1627,9 +1627,9 @@
 MODULE_DEVICE_TABLE(pci, agp_pci_table);
 
 static struct pci_driver agp_pci_driver = {
-	name:		"agpgart",
-	id_table:	agp_pci_table,
-	probe:		agp_probe,
+	.name		= "agpgart",
+	.id_table	= agp_pci_table,
+	.probe		= agp_probe,
 };
 
 static int __init agp_init(void)
diff -Nru a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
--- a/drivers/char/agp/frontend.c	Wed Jul 24 11:46:05 2002
+++ b/drivers/char/agp/frontend.c	Wed Jul 24 11:46:05 2002
@@ -1050,14 +1050,14 @@
 
 static struct file_operations agp_fops =
 {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		agp_read,
-	write:		agp_write,
-	ioctl:		agp_ioctl,
-	mmap:		agp_mmap,
-	open:		agp_open,
-	release:	agp_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= agp_read,
+	.write		= agp_write,
+	.ioctl		= agp_ioctl,
+	.mmap		= agp_mmap,
+	.open		= agp_open,
+	.release	= agp_release,
 };
 
 static struct miscdevice agp_miscdev =
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	Wed Jul 24 11:46:05 2002
+++ b/drivers/char/agp/i460-agp.c	Wed Jul 24 11:46:05 2002
@@ -533,8 +533,8 @@
 static struct gatt_mask intel_i460_masks[] =
 {
 	{
-	  mask: INTEL_I460_GATT_VALID | INTEL_I460_GATT_COHERENT,
-	  type: 0
+	  .mask = INTEL_I460_GATT_VALID | INTEL_I460_GATT_COHERENT,
+	  .type = 0
 	}
 };
 
