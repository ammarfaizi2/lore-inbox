Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRKOSwr>; Thu, 15 Nov 2001 13:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280993AbRKOSwi>; Thu, 15 Nov 2001 13:52:38 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:60678 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280992AbRKOSw1>;
	Thu, 15 Nov 2001 13:52:27 -0500
Date: Thu, 15 Nov 2001 11:51:04 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Symbols missing help
Message-ID: <20011115115104.D10955@kroah.com>
In-Reply-To: <20011115023337.A1724@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115023337.A1724@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 17:44:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 02:33:37AM -0500, Eric S. Raymond wrote:
> USB_SERIAL_IR

Here's the patch against 2.4.15-pre4 for this symbol.

thanks,

greg k-h

diff --minimal -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Nov 15 10:46:22 2001
+++ b/Documentation/Configure.help	Thu Nov 15 10:46:22 2001
@@ -12717,6 +12717,17 @@
   The module will be called visor.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+USB IR Dongle Serial Driver
+CONFIG_USB_SERIAL_IR
+  Say Y here if you want to enable simple serial support for USB IrDA
+  devices.  This is useful if you do not want to use the full IrDA
+  stack.
+  
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called ir-usb.o. If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
 USB Belkin and Paracom Single Port Serial Driver
 CONFIG_USB_SERIAL_BELKIN
   Say Y here if you want to use a Belkin USB Serial single port
