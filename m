Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUA0PBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUA0PBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:01:22 -0500
Received: from mail.broadpark.no ([217.13.4.2]:40347 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263760AbUA0PBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:01:21 -0500
From: Frank Aune <faune@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: nvidia nforce3 support
Date: Tue, 27 Jan 2004 15:56:39 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401271556.40135.faune@stud.ntnu.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What is the status for nforce3 support in 2.4 and 2.6? Ive found a patch from 
google dating all the way back in nov 2003, but it doesnt seem like its been 
applied. FYR here is the google search link:

http://groups.google.com/groups?q=nforce3
+linux&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=JSef.Wi.19%40gated-at.bofh.it&rnum=1

When trying the agpgart and nvidia_agp module on my nforce3 system, I get this 
message in dmesg:

agpgart: Detected an NVIDIA nForce/nForce2 chipset, but could not find the 
secondary devices.

Right now Im using 2.6.2-rc2-mm2, but 2.4.24 also give the same message. What 
is this "secondary devices" it cant find? Is this related to an unsupported 
AGP card? (Im using an Creative ATI Radeon 9200SE, and I cant enable direct 
rendering - only been able to use X version 4.3.99.902 and its built-in 
driver.)

I'll be happy to provide DeviceIDs and test patches, if someone needs it.

Thank you.

