Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJVKxz>; Tue, 22 Oct 2002 06:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSJVKxz>; Tue, 22 Oct 2002 06:53:55 -0400
Received: from mx5.mail.ru ([194.67.57.15]:43531 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id <S262434AbSJVKxv>;
	Tue, 22 Oct 2002 06:53:51 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 386 + TSC -> none good
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Tue, 22 Oct 2002 14:59:38 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E183wl8-000GM4-00@f9.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        It seems that some config breakage have sneaked past the people in
 position due to the fact little people use 386-powered boxens nowadays ;)

        The result being a menuconfig selection of 386 cpu in 2.4.20-pre9
 producing a .config with a CONFIG_X86_ENABLE_TSC (or was it _USE_TSC?).
  2.4.19-rc1 which i`ve ran before has no problem with it.

        I`ve built the kernel without looking at the resulting .config
 and then i was able to admit that my 386 somehow lacks "the TSC feature"

---
cheers,
   Samium Gromoff
_____________________________________
_____________________________

