Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbTIJTmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbTIJTlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:41:44 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:43709
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id S265664AbTIJTk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:40:26 -0400
X-Mailbox-Line: From galia@st-peter.stw.uni-erlangen.de  Wed Sep 10 21:40:23 2003
Message-ID: <1063222822.3f5f7e2696eda@secure.st-peter.stw.uni-erlangen.de>
Date: Wed, 10 Sep 2003 21:40:22 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wierd raid 1 problem(sort of)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
i'm seeing similar problems with the bad side that the files never recover :(

this is a Epox 8k9a3+ ,
4 IBM deskstar on the HPT374 as masters in raid-1 & raid-5,
with or without lvm1( resently recreated with LVM2)

when i use md( or lvm over md) the data gets corrupted ,
if i use the partitions which are under the md as normal partitions
there is no coruption, if i create md over them again - again corruption

dma seems to be OK since 2.4.21ac1 & 2.4.22pre in case i use acpi=off pci=noacpi
which also allows me to use usb and onboard lan

the same setup had never had problems with erlier kernels 
on a Epox 8k5a3+ but it died
(i moved the drives from dead board to the new one, which is basicly the same
only uses KT333 instead of KT400 in the 8k9a3+)


best,

svetljo

PS.
please CC me as i'm not subscribed to the list
-- 


