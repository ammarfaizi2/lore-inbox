Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSJWAxT>; Tue, 22 Oct 2002 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbSJWAxT>; Tue, 22 Oct 2002 20:53:19 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:6598 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262328AbSJWAxS>; Tue, 22 Oct 2002 20:53:18 -0400
Date: Tue, 22 Oct 2002 20:51:53 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/scsi/FlashPoint.c
Message-ID: <Pine.LNX.4.44.0210222050030.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch removes STATIC macro references.
Regards,
Frank

--- linux/drivers/scsi/FlashPoint.c.old	Sat Oct 19 12:05:40 2002
+++ linux/drivers/scsi/FlashPoint.c	Tue Oct 22 20:28:47 2002
@@ -2926,7 +2926,7 @@
 
 
 
-STATIC s16bits FP_PresenceCheck(PMGR_INFO pMgrInfo)
+static s16bits FP_PresenceCheck(PMGR_INFO pMgrInfo)
 {
 	PMGR_ENTRYPNTS	pMgr_EntryPnts = &pMgrInfo->mi_Functions;
 
@@ -2972,7 +2972,7 @@
  * Description: Setup and/or Search for cards and return info to caller.
  *
  *---------------------------------------------------------------------*/
-STATIC s32bits probe_adapter(PADAPTER_INFO pAdapterInfo)
+static s32bits probe_adapter(PADAPTER_INFO pAdapterInfo)
 {
    u16bits temp,temp2,temp3,temp4;
    u08bits i,j,id;
@@ -3324,7 +3324,7 @@
  * Description: Setup adapter for normal operation (hard reset).
  *
  *---------------------------------------------------------------------*/
-STATIC CARD_HANDLE init_adapter(PADAPTER_INFO pCardInfo)
+static CARD_HANDLE init_adapter(PADAPTER_INFO pCardInfo)
 {
    PSCCBcard CurrCard;
 	PNVRamInfo pCurrNvRam;
@@ -3625,7 +3625,7 @@
  * Function: GetDevSyncRate
  *
  *---------------------------------------------------------------------*/
-STATIC  int GetDevSyncRate(PSCCBcard pCurrCard,PUCB p_ucb)
+static  int GetDevSyncRate(PSCCBcard pCurrCard,PUCB p_ucb)
 {
 	struct _SYNC_RATE_INFO * pSyncStr;
    PSCCBMgr_tar_info currTar_Info;
@@ -3705,7 +3705,7 @@
  * Function: SetDevSyncRate
  *
  *---------------------------------------------------------------------*/
-STATIC int SetDevSyncRate(PSCCBcard pCurrCard, PUCB p_ucb)
+static int SetDevSyncRate(PSCCBcard pCurrCard, PUCB p_ucb)
 {
 	struct _SYNC_RATE_INFO * pSyncStr;
    PSCCBMgr_tar_info currTar_Info;

