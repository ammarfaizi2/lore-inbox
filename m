Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132000AbRCVMvO>; Thu, 22 Mar 2001 07:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132013AbRCVMvE>; Thu, 22 Mar 2001 07:51:04 -0500
Received: from mx6.port.ru ([194.67.23.42]:37646 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S132000AbRCVMuv>;
	Thu, 22 Mar 2001 07:50:51 -0500
From: "Parity Error" <bootup@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: current->need_reshed, can it be a global flag ?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 144.16.67.146 via proxy [144.16.67.8]
Reply-To: "Parity Error" <bootup@mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E14g4XZ-0009hb-00@f5.mail.ru>
Date: Thu, 22 Mar 2001 15:50:09 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

instead of need_reshed being a per-task flag, could it be
as a global flag ?, since every time current->need_reshed
is checked, schedule() is just called to pick another
process.

---
Получите и Вы свой бесплатный электронный адрес на http://Mail.ru

