Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSA0JgL>; Sun, 27 Jan 2002 04:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSA0JgB>; Sun, 27 Jan 2002 04:36:01 -0500
Received: from mail215.mail.bellsouth.net ([205.152.58.155]:23329 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S287894AbSA0Jfw>; Sun, 27 Jan 2002 04:35:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: SI Reasoning <sczjd@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: issues with 2.4.18 kernel and Dell Inspiron 8000
Date: Sun, 27 Jan 2002 03:35:37 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020127093703.ZSOL27069.imf15bis.bellsouth.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to the list so please CC me your responses.

I participate in Mandrake's Cooker development and have been running into 
some power management issues with the latest kernel. Below is the message I 
had sent as well as the reply which pointed me in this direction:

On 2002-01-27 at 11:43, SI Reasoning wrote:
> When halting my Dell Inspiron 8000, I get the power
> off message but the laptop does not power off while
> using the 2.4.17-10mdk kernel. Other APM related stuff is
> a mess with this laptop also. If it suspends or does
> any power saving features, it can not be brought back
> up and has to be rebooted. Even worse, if I try to go
> to bios or check the battery feature, it completely
> locks up the computer and it has to be forcibly turned
> off.
> > Kernel 2.4.16-11mdk was way better. It still had the
> suspend issue, but I could go to the bios or battery
> display and other bios related shortcuts without
> issue. It also powered down without issue.

2.4.18-pre7 (that 2.4.17-10mdk is based upon) has new APM patch. I
already have seen other reports about APM related problems in this
version (ironically this patch fixed problem I had).

I suggest you report it on lkml as you may have better chances there.

-andrej


