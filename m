Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRCKVlF>; Sun, 11 Mar 2001 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRCKVk4>; Sun, 11 Mar 2001 16:40:56 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:23049 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129156AbRCKVkq>; Sun, 11 Mar 2001 16:40:46 -0500
Message-Id: <200103112139.WAA08138@fire.malware.de>
Date: Sun, 11 Mar 2001 22:39:24 +0100
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-ac1 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in __mark_inode_dirty (2.4.2-pre3)
In-Reply-To: <200103111232.NAA02902@fire.malware.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i wrote:
> EIP:    0010:[__mark_inode_dirty+92/112]
> EFLAGS: 00010202
> eax: 00000000   ebx: cc85b240   ecx: cc85b428   edx: cc85b248
> esi: c15dc200   edi: 00000001   ebp: c361dfa4   esp: c361df24
       ^^^^^^^^

This is a bit-flipper. There is a valid super-block entry at c14dc200.


Michael
