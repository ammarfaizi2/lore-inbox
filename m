Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVIJHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVIJHmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVIJHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:42:36 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:24960 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S932265AbVIJHmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:42:36 -0400
Message-ID: <43228E4E.4050103@jg555.com>
Date: Sat, 10 Sep 2005 00:42:06 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Pure 64 bootloaders
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on a project to create a Pure 64 bit distro of 
linux, nothing 32 bit in the system. I can accomplish that with no 
issues pretty much on all platforms, with the exception of the 
bootloaders. It just seems odd, that all the bootloaders seem to have 
gcc -m32 in their makefiles.

Silo on the Sparc has gcc -m32
Grub on the x86 platforms has gcc -m32
 
The only one that builds and works is Lilo, which most people are moving 
away from.

So for my question, why does a bootloader have to be 32bit?
Anyone got 64 bit bootloaders for Sparc or x86_64 machines?
Are there technical limitations that bootloaders can't be 64 bit?
If we can't have a pure64 environment, why does the Kernel support it?

Thank you all for taking you time to respond.

-- 
----
Jim Gifford
maillist@jg555.com

