Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSEQAzX>; Thu, 16 May 2002 20:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSEQAzW>; Thu, 16 May 2002 20:55:22 -0400
Received: from pl204.dhcp.adsl.tpnet.pl ([217.98.31.204]:36736 "EHLO
	bzzzt.slackware.pl") by vger.kernel.org with ESMTP
	id <S315245AbSEQAzV>; Thu, 16 May 2002 20:55:21 -0400
Date: Fri, 17 May 2002 02:57:07 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
X-X-Sender: <pkot@bzzzt.slackware.pl>
To: <linux-kernel@vger.kernel.org>
cc: <linux-ntfs-dev@lists.sourceforge.net>
Subject: [ANN] NTFS 2.0.7c for Linux 2.4.18
Message-ID: <Pine.LNX.4.33.0205170249300.377-100000@bzzzt.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As Arek Miskiewicz reported to me, the previous NTFS TNG versions didn't
compile with CONFIG_HIGHMEM. The compilation failed due to lack of the
definition of the KM_BIO_IRQ used in the NTFS code.

In this release KM_BIO_IRQ was added to km_type enum on all platforms
supporting it (sparc, ppm, i386).

If you don't use HIGHMEM support or use other architecture the changes
don't touch you.

The patch is available as always from the linux-ntfs project's page:
http://linux-ntfs.sf.net/downloads.html

As usually big thanks to Anton.

pkot
-- 
Pawel Kot <pkot@linuxnews.pl>
http://www.gnokii.org/ :: http://www.slackware.pl/
http://kt.linuxnews.pl/ -- Kernel Traffic po polsku


