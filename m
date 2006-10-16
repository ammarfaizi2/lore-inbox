Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWJPM0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJPM0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWJPM0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:26:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:20308 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422651AbWJPM0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mTFLWDLTYlRaBBRoagH6JEl4jktaNS5N9c7lQJllBU8L/zFhl7c5OH7vAW5GOWilRbp45y600Uou82LVMGp4txiH+PLr2uMmBmMGAAxs3dIadya5ZlRQMPnUe0Yfly2/QPGSAVcWxWHW2f//MlMwSCfz3KbVjUQZ0pJ2ROklkq4=
Message-ID: <1b270aae0610160526w66738ea6ud91aaad3a862170@mail.gmail.com>
Date: Mon, 16 Oct 2006 14:26:45 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: Hardware random intel_rng broken in x86_64 mode on 2.6.18
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the hwrandom with intel_rng seems to be broken at least on 2.6.18;
Chipset is an E7520 on a SE7520JR2 board; Dual Intel Xeon 3.0 GHz CPU
running in 64bit mode. The output of /dev/hw_random consists entirely
of '1's.

dmesg says:
Intel 82802 RNG detected

hexdump of the data:
0000000 ffff ffff ffff ffff ffff ffff ffff ffff

Is this a known problem?
Cheers,
M
