Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSK0Ttu>; Wed, 27 Nov 2002 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSK0Ttu>; Wed, 27 Nov 2002 14:49:50 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:36738 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S264714AbSK0Ttu>; Wed, 27 Nov 2002 14:49:50 -0500
Date: Wed, 27 Nov 2002 11:57:08 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200211271957.gARJv8n15757@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PDC20267 fails (in different ways) with 2.4.20-rc3 and
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan cox <alan@lxorguk.ukuu.org.uk> writes:

>> I have a PDC20267 that works with 2.4.19-ac4.
>> With 2.4.20-rc3 the machine hangs at checking filesystems.
>> With 2.4.20-rc2-ac3 the machine boots but the PDC20267 is not detected at all.
>>
>Make sure you compiled in the pdc202xx_old driver - the pdc driver was
>split into two

That did it Alan, thanks. Now happily running 2.4.20-rc4-ac1.

