Return-Path: <linux-kernel-owner+w=401wt.eu-S932418AbXAGGk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbXAGGk3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAGGk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 01:40:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:47140 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbXAGGk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 01:40:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o99ZqJltLOwKx6h9GjrCMqbiqGTH2zPakgAVx8rWMbJF2koY2h7anrMxPljhch+HbHQ9JblttkEQflUoO4ZqjlU9jb+xXodW4tY75Dj4xyuB2gKdYs6pJzvV2ygUyMd6JImxko6vnNC9Dh/yg/7o3Sb7fnfzlivJzsU2lmXB+Mo=
Message-ID: <652016d30701062240w4756bc4m8fdb54070708fd81@mail.gmail.com>
Date: Sun, 7 Jan 2007 12:25:27 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ATA streaming feature support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
   First of all sorry for bringing this topic again.
As discussed in  --> http://lkml.org/lkml/2006/5/5/47
The ATA Streaming feature set is not necessary to be in Kernel Space
(IDE driver). There is a suggestion creating user space library.

But how is the user space apps going to use the commands like READ
STREAM DMA EXT (0x2A). Shouldn't there be some support in kernel which
setups up PRD tables  and all.
It doesn't seem to be possible.... is it?

Does it sound normal if we have something like O_STREAM in open() or a
seperate IOCTL to command the driver to use STREAM commands (if
supported).

Will this feature be useful for streaming media apps like DVRs? (i am
working in one such.)


-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
