Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272501AbRHaDdI>; Thu, 30 Aug 2001 23:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272553AbRHaDc6>; Thu, 30 Aug 2001 23:32:58 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:40208 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S272501AbRHaDcr>; Thu, 30 Aug 2001 23:32:47 -0400
Subject: [PATCH] 2.4.9/2.4.10 Let net devices contribute entropy
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <998616119.9306.32.camel@phantasy>
In-Reply-To: <998616119.9306.32.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 30 Aug 2001 23:33:11 -0400
Message-Id: <999228794.5832.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patches to optionally enable network devices to feed the kernel
entropy pool are available for both 2.4.10-pre2 and 2.4.9-ac5.  The
patches come in two parts, part one containing the new code and related
bits and part two containing updates to (hopefully) all network devices
to enable the new support (and remove mandatory contribution for those
devices that do so now).

Apply both patches and enable the new option in `Network Devices'.

Patches accepted for missing architectures and drivers. Comments
desired.  For a length discussion of the patch and the entropy gatherer
in general, see the previous threads.

For 2.4.9-ac5:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac5-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.9-ac5-netdev-random-2

For 2.4.10-pre2:
http://tech9.net/rml/linux/patch-rml-2.4.10-pre2-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.10-pre2-netdev-random-2

Enjoy.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

