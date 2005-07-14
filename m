Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVGNR7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVGNR7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVGNR7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:59:06 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:65478 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262823AbVGNR7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:59:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UVoV/Pc2YiP50cygnzGZpuj/XTipuYFNQXoH7lRRa4oGNTCDsq/rjj4+kTbJ2EPRaByP1h4h0k1HxbuzwYYEeuUI+g6ISYUCwkmer9wRknuioM59uO/TChlGhFtvL/czBR8ynCMCoVNTfxt6opnV1YwKOJpv7TwCudin3THPAJo=
Message-ID: <2ea3fae10507141058c476927@mail.gmail.com>
Date: Thu, 14 Jul 2005 10:58:16 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>
Subject: NUMA support for dual core Opteron
Cc: LinuxBIOS <linuxbios@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone mentioned that NUMA support for dual core opteron need acpi
support in LinuxBIOS.

there may be some other solution for that.
1. PowerPC already support dual core and it should support NUMA, So
the Open Firmware must have some NUMA entry definition.
Can we make x86-64 kernel support OpenFirmware interface so we can use
OpenBIOS as payload of LinuxBIOS.
2. enable acpi and add the NUMA entries into it, the Linux Kernel will be happy.
3. If we are trying to use ADLO to load Windows/Solaris/FreeBSD, We
need to pass related acpi info to ADLO....

Solution 1 will be ideal one, and can make Solaris for X86-64 use
OpenFirmware interface too.....

which one is better?

YH
