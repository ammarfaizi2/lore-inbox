Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSGROlR>; Thu, 18 Jul 2002 10:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318112AbSGROlR>; Thu, 18 Jul 2002 10:41:17 -0400
Received: from aries.i-cable.com ([210.80.60.86]:1004 "HELO aries.i-cable.com")
	by vger.kernel.org with SMTP id <S318105AbSGROlQ>;
	Thu, 18 Jul 2002 10:41:16 -0400
Subject: [Bug report] USB lockup
From: Jacky Lam <sylam@emsoftltd.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Jul 2002 22:43:58 +0800
Message-Id: <1027003438.11402.5.camel@cm61-10-74-235.hkcable.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

	I experience an USB lockup since I upgrade my kernel from 2.4.19-pre6
to 2.4.19-pre7. The problem seems to be caused by the correction of
is_suspended variable initialsation in /driver/usb/uhci.c which may the
suspend code actually runs. I don't know why my USB doesn't wake up
after suspended. 

	I have tested with 2.5.26 and all works fine.

Regards,
Jacky



