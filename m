Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUIOM5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUIOM5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUIOM4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:56:53 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15101 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S265489AbUIOMxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:53:46 -0400
Date: Wed, 15 Sep 2004 08:55:47 -0400
From: Andre Bonin <kernel@bonin.ca>
Subject: PCI coprocessors
To: linux-kernel@vger.kernel.org
Message-id: <41483BD3.4030405@bonin.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2)
 Gecko/20040803
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
I'me building an FPGA based pci board for a degree project.  In theory 
this board could be used as a custom, field programmable coprocessor (to 
accelerate processes).  At which point, it might be nice to be able to 
support it as a processor under the kernel.

Yes bandwidth, yes it should be PCI-Express but it is still just a 
degree project, 33mhz is fast enough for the proof of concept.

Which leads me to my questions:

1) Is their support for having two different 'machine types' within one 
kernel? that is for example, certain executables for intel would get run 
on an intel processor, and others would get run on processor with type XXXX.

I heard once someone put native "java" .class support within the kernel 
(it would call the jvm run time if i remember).  I could maby do this 
with my own set of libraries and driver.  But differentiating between 
the types of executable might be hard.

2) Is their kernel support for PCI coprocessors for thread allocation 
etc.  I couldn't find any but i can try looking through the code again.






