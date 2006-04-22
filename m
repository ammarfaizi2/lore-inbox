Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWDVULs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWDVULs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDVULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:11:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751129AbWDVULr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:11:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tbw+Vf6cyv0wSjyMnVs8hTxX8LMJvbqSHv/UwoOFiTNU/Gj5DYUb/QEtohfnSMOIigmBeqwIWcI0GBq800whrVsCjYFxMSNjBJx+k0jEkbbL1TTBE5zjZt5msHCx11IM4Ev+CWqsjcwtTq6l5gb5zsnzu/DoOUBaxVzfvNDwJgg=
Message-ID: <877aabc40604220446h282f2d77n92b0e7094926ed87@mail.gmail.com>
Date: Sat, 22 Apr 2006 17:16:19 +0530
From: "Amit Shah" <shahamit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 'Drive not ready for command' for Sony DRU-810A
In-Reply-To: <1145705636.499865.26770@j33g2000cwa.googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145705636.499865.26770@j33g2000cwa.googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these messages when I access a DVD or a CD in my Sony DRU-801A
drive when playing a video DVD. Mounting and listing contents works
fine. I'm running 2.6.16.1.

[4295399.070000] hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4295399.070000] hdc: drive not ready for command
[4295399.070000] hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4295399.070000] hdc: drive not ready for command
[4295399.070000] hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4295399.070000] hdc: drive not ready for command
[4295399.070000] hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
[4295399.070000] hdc: drive not ready for command
[4295399.120000] hdc: ATAPI reset complete
[4295399.649000] hdc: cdrom_read_intr: Bad transfer size 65534
[4295399.649000] end_request: I/O error, dev hdc, sector 192
[4295399.649000] Buffer I/O error on device hdc, logical block 24

Any pointers will be appreciated.

Please let me know if  you need more info.

Amit
--
Amit Shah
http://amitshah.net/
