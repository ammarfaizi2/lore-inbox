Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSAPTnQ>; Wed, 16 Jan 2002 14:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSAPTm6>; Wed, 16 Jan 2002 14:42:58 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:25217 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287333AbSAPTmk>; Wed, 16 Jan 2002 14:42:40 -0500
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
MIME-Version: 1.0
Subject: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDECC5A17.29748904-ON85256B43.006B2B67@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Wed, 16 Jan 2002 13:42:13 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/16/2002 02:42:15 PM,
	Serialize complete at 01/16/2002 02:42:15 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several bugs and works around known hardware problems 
which conspired to lock up the system randomly.  Its somewhat large, 
therefore available at:

http://oss.software.ibm.com/developer/opensource/linux/patches/tr/lanstreamer-0.5.1.patch.gz

* Interrupt function rearranged
* PCI Configuration changed
* Tx descriptors had to be reduced to 1 (!)
* Send/Receive operations are nearly serialized

Please apply.

Thanks,
Kent <yoder1@us.ibm.com>
