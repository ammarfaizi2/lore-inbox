Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265481AbRF2DK7>; Thu, 28 Jun 2001 23:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRF2DKj>; Thu, 28 Jun 2001 23:10:39 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:46596 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265474AbRF2DKb>;
	Thu, 28 Jun 2001 23:10:31 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ignacio Monge <ignaciomonge@navegalia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Configure and compile errors in 2.4.5ac20 and 2.4.5ac21 
In-Reply-To: Your message of "Fri, 29 Jun 2001 02:54:21 -0400."
             <20010629025421.6d021d7a.ignaciomonge@navegalia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 13:10:25 +1000
Message-ID: <23666.993784225@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001 02:54:21 -0400, 
Ignacio Monge <ignaciomonge@navegalia.com> wrote:
>	1.- Entering in "Network Device support"-->Ethernet (10 or 100Mbit) 
>--->causes an error:
>	 Q> scripts/Menuconfig: MCmenu31: command not found

Against 2.4.5-ac21.

Index: 5.52/drivers/net/Config.in
--- 5.52/drivers/net/Config.in Fri, 29 Jun 2001 11:39:55 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644)
+++ 5.52(w)/drivers/net/Config.in Fri, 29 Jun 2001 12:14:23 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644)
@@ -16,7 +16,7 @@ if [ "$CONFIG_EXPERIMENTAL" = "y" ]; the
 fi
 
 if [ "$CONFIG_ISAPNP" = "y" ]; then
-   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000 $CONFIG_ISAPNP
+   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000
 fi
 
 #
@@ -204,7 +204,6 @@ bool 'Ethernet (10 or 100Mbit)' CONFIG_N
       dep_tristate '    D-Link DE600 pocket adapter support' CONFIG_DE600 $CONFIG_ISA
       dep_tristate '    D-Link DE620 pocket adapter support' CONFIG_DE620 $CONFIG_ISA
    fi
-fi
 
 endmenu
 

