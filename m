Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWIERs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWIERs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWIERsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:48:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5088 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965229AbWIERsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kOsXehI1TVwMyYP8kba13X3jFEWcRxfV6T4/x7Vp4Wr2l2xkTSlYy6ChT8TP1gGgWEkr9H1poGZFGZlWwwFhlmdryxLOBiA9fpq1zEG2AoTYLes9zYrDXVXBEj+R4ywqwVfxZTLVRG8rYDwXaQkckqTH/ha98VzxpUaDyp2t8OY=
Message-ID: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
Date: Tue, 5 Sep 2006 10:48:23 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: howto map HDT dumped addresses to AMD64 kernel virtual addresses.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running a kernel (Suse Enterprise 9 with SP3) and it is hanging
somewhere in the kernel. By hooking up HDT from AMD, I got a the
assembly dump of the routine which causes the infinite loop. How
should I map the addresses dumped by HDT in the format SEG:Offset
(e.g,
0033:00000000_00400C18   mov   esi,[loc_0000000000501a64h]
0033:00000000_00400C1E   test   esi,esi
0033:00000000_00400C20   jz   loc_0000000000400c30h
...etc)
to kernel virtual address space?

Regards,
Om.
