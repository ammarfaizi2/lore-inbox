Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319054AbSH2ECx>; Thu, 29 Aug 2002 00:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319052AbSH2ECx>; Thu, 29 Aug 2002 00:02:53 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:44495 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP
	id <S318998AbSH2ECx>; Thu, 29 Aug 2002 00:02:53 -0400
Message-ID: <3D6D9D56.2090806@bellatlantic.net>
Date: Thu, 29 Aug 2002 00:04:38 -0400
From: dtonks <dtonks@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.31 SCSI problem w/solution
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    When trying to compile module for sym53c416 I received an error 
'address not in structure'.  I traced this to - asm-i386/scatterlist.h. 
 It is missing - char * address - at the beginning of the structure.  I 
copied scatterlist.h from 2.4.18 and it compiled fine.

Hope this helps,
Don Tonks
dtonks@bellatlantic.net

