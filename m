Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263307AbRFABbZ>; Thu, 31 May 2001 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbRFABbP>; Thu, 31 May 2001 21:31:15 -0400
Received: from patan.Sun.COM ([192.18.98.43]:37807 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263307AbRFABbH>;
	Thu, 31 May 2001 21:31:07 -0400
Message-ID: <3B16F0BD.8B574EC2@sun.com>
Date: Thu, 31 May 2001 18:32:45 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: [PATCH] HPT370 misc
In-Reply-To: <Pine.LNX.4.10.10103272243300.17821-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

Attached is a patch for hpt366.c for the following:
	better support for multiple controllers
	better /proc output
	66 MHz PCI timings
	implement the HDIO_GET/SET_BUSSTATE ioctls (see previous patch)

This patch does rely on the PCI busspeed patch (sent to lkml earlier).

Please let me know if you have any problems with this for general
inclusion.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
