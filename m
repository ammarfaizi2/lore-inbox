Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRJMATx>; Fri, 12 Oct 2001 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278217AbRJMATc>; Fri, 12 Oct 2001 20:19:32 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:12272 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S278212AbRJMAT2>; Fri, 12 Oct 2001 20:19:28 -0400
Date: Sat, 13 Oct 2001 01:14:40 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ieee1284_ops.c - definitely paper bag time for someone..
Message-ID: <Pine.LNX.4.33.0110130113130.4284-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.12/drivers/parport/ieee1284_ops.orig      Sat Oct 13 01:12:14 2001
+++ linux-2.4.12/drivers/parport/ieee1284_ops.c Sat Oct 13 01:11:26 2001
@@ -362,7 +362,7 @@
        } else {
                DPRINTK (KERN_DEBUG "%s: ECP direction: failed to
reverse\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }

        return retval;
@@ -394,7 +394,7 @@
                DPRINTK (KERN_DEBUG
                         "%s: ECP direction: failed to switch forward\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }



-- 
Top posters will be automatically killfiled.

http://www.tahallah.demon.co.uk

