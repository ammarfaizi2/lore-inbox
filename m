Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317970AbSGPUPz>; Tue, 16 Jul 2002 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317973AbSGPUPy>; Tue, 16 Jul 2002 16:15:54 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:18401 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317970AbSGPUPx>; Tue, 16 Jul 2002 16:15:53 -0400
Message-ID: <3D347F9B.58740355@nortelnetworks.com>
Date: Tue, 16 Jul 2002 16:18:35 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Second x86-64 kernel snapshot based on 2.4.19rc1 released
References: <20020716220302.A5400@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> - vsyscalls are currently disabled because they trigger too many linker bugs together
> with HPET timers. The vsyscall pages just call normal syscalls.

I assume that the linker is going to get fixed before general x86-64 release so
these can be used together?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
