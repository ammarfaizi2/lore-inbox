Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbSIYTZv>; Wed, 25 Sep 2002 15:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSIYTZv>; Wed, 25 Sep 2002 15:25:51 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:58035 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262077AbSIYTZu>; Wed, 25 Sep 2002 15:25:50 -0400
Message-ID: <3D920EAE.2020602@informatik.tu-chemnitz.de>
Date: Wed, 25 Sep 2002 21:29:50 +0200
From: Janek Neubert <janek.neubert@informatik.tu-chemnitz.de>
Reply-To: Janek Neubert <janek.neubert@informatik.tu-chemnitz.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Error with i845G
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17uHsI-0003ws-00*aqPNb.vDC8M*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have a bought an EPOX board (4G4A+) with Intel i845G chipset. While i was 
trying a 2.4.18 kernel, the machine stops after "Ok, booting the kernel ...". I 
have to use the lilo command mem=<memory without shared graphic ram>M in 
megabytes. All kernels newer than 2.4.3 cause this error. Since version 2.4.19, 
this solution is unusable. I think, this is a kernel problem, because i know 
from other people having the same problem, but other boards with i845G. I need 
the 2.4.19 to use my HPT372. Please help and finf the error.

I think the problem is a failure in the routine getting the size of memory from 
BIOS. Linux thinks, i have 640k!!! RAM. Only the mem-parameter can solve it.

Thx

janek

p.s. please send a cc to my email, i haven't subscribed this list

