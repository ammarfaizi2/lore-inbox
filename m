Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSKZOcI>; Tue, 26 Nov 2002 09:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKZOcI>; Tue, 26 Nov 2002 09:32:08 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:36310 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266319AbSKZOcH>;
	Tue, 26 Nov 2002 09:32:07 -0500
Date: Tue, 26 Nov 2002 15:37:17 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: APM IOC REJECT ?
To: linux-kernel@vger.kernel.org
Message-id: <3DE3871D.3360BCA5@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What is keeping hte APM REJECT ioctl from getting into the kernel ?
The patch was first released eons ago.

With it, you can assign any function to the power button ( and to the
sleep button if anyone has one ), without it, the power button crashes
the system ( actually it first informs linux that a suspend is pending,
and then it cuts the power. useless At least that's my experience with
it).

apmd also supports this feature since long.


Regards,
david
