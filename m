Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSHJTyQ>; Sat, 10 Aug 2002 15:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHJTyQ>; Sat, 10 Aug 2002 15:54:16 -0400
Received: from ppp73-2-69.miem.edu.ru ([194.226.32.69]:26752 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S317302AbSHJTyQ>;
	Sat, 10 Aug 2002 15:54:16 -0400
Message-ID: <3D556EF1.5010708@yahoo.com>
Date: Sat, 10 Aug 2002 23:52:17 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] vm86 bugs in 2.5.30
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kasper Dupont wrote:
> <4> invalid operand: 0000 
> <4>Code: Bad EIP value. 
> It happens during the vm86 system call, but it is not fixed 
> by any of the changes in vm86.c. Who remember which patch 
> fixed this problem?
This one:
http://dosemu.sourceforge.net/stas/traps.diff
Was not included in 2.4.19, exists only in -ac
for now.

