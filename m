Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTFKTqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:46:31 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:64132
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S263786AbTFKTqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:46:21 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: Problem compile module vmnet VMWARE 4.0 in 2.4.70-mm8
Date: Wed, 11 Jun 2003 13:30:40 -0600
Message-Id: <20030611192737.M39931@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi:

    I have problems when compile module vmware 4.0 vmnet with kernel 2.5.70-mm8.

    the messages is:

    kernel? [/lib/modules/2.5.70-mm8/build/include]
 
Extracting the sources of the vmmon module.
 
Building the vmmon module.
 
make: Entering directory `/tmp/vmware-config0/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config0/vmmon-only'
make[2]: Entering directory `/tmp/vmware-config0/vmmon-only/driver-2.5.70-mm8'
make[2]: Leaving directory `/tmp/vmware-config0/vmmon-only/driver-2.5.70-mm8'
make[2]: Entering directory `/tmp/vmware-config0/vmmon-only/driver-2.5.70-mm8'
make[2]: Leaving directory `/tmp/vmware-config0/vmmon-only/driver-2.5.70-mm8'
make[1]: Leaving directory `/tmp/vmware-config0/vmmon-only'
make: Leaving directory `/tmp/vmware-config0/vmmon-only'
The module loads perfectly in the running kernel.
 
Extracting the sources of the vmnet module.
 
Building the vmnet module.
 
make: Entering directory `/tmp/vmware-config0/vmnet-only'
bridge.c: In function `VNetBridgeReceiveFromVNet':
bridge.c:368: structure has no member named `wmem_alloc'
bridge.c: In function `VNetBridgeUp':
bridge.c:618: structure has no member named `protinfo'
bridge.c: In function `VNetBridgeReceiveFromDev':
bridge.c:817: structure has no member named `protinfo'
make: *** [bridge.o] Error 1
make: Leaving directory `/tmp/vmware-config0/vmnet-only'
Unable to build the vmnet module.
 
For more information on how to troubleshoot module-related problems, please
visit our Web site at "http://www.vmware.com/download/modules/modules.html" and
"http://www.vmware.com/support/reference/linux/prebuilt_modules_linux.html".
 
Execution aborted.


   Helpme please.

   Best Regards.
