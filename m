Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJKRpS>; Thu, 11 Oct 2001 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276634AbRJKRpM>; Thu, 11 Oct 2001 13:45:12 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:5179 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276600AbRJKRon>; Thu, 11 Oct 2001 13:44:43 -0400
Subject: Re: 2.4.12: IEEE-1284 won't compile
From: Robert Love <rml@tech9.net>
To: swsnyder@home.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01101108285301.04104@mercury.snydernet.lan>
In-Reply-To: <01101108285301.04104@mercury.snydernet.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 11 Oct 2001 13:45:08 -0400
Message-Id: <1002822315.864.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 09:28, Steve Snyder wrote:
> Patched from 2.4.11 on a RedHat v7.1 system, no errors seen in patching:

--- ieee1284_ops.c~     Thu Oct 11 11:10:37 2001
+++ ieee1284_ops.c      Thu Oct 11 11:22:31 2001
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
                         "%s: ECP direction: failed to switch
forward\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }



	Robert Love

