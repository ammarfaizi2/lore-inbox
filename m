Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCCTnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCCTnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCCTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:42:42 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:26869 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262525AbVCCT2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:28:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=FK3TwupTC9lI30t5g31GcdFbnLV0zJ/kzY17zY8CT19v5wQWFdadBQ/sxG3g3zwY+Qog8V6U0cRRQ8xFFgiTF87xooxEtrBHJ07q1pPQCUmZHLvyFUYOR4lh/zfI7zhr+VJGbNt0D4BCXFSWdbXXfeqzHRd+9lNwUOlZzh2BpDc=
Message-ID: <c9ad856005030311286314ebfd@mail.gmail.com>
Date: Thu, 3 Mar 2005 13:28:41 -0600
From: V P <upathiyayan@gmail.com>
Reply-To: V P <upathiyayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I/O error propagation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question on how disk errors get propagated to
the file systems.

>From looking at the SCSI/IDE drivers, it looks like there
could be many reasons for an I/O to fail. It could be
bus timeout, media errors, and so on.

Does all these errors get reported to the file system ?
It looks like all the different types of errors get
turned into a single I/O error (-EIO) and passed on to the
file system.

Or is there a way where we can export better error codes
to the file system ?

Any idea/input regarding this is greatly appreciated.

Thanks.
