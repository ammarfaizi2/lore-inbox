Return-Path: <linux-kernel-owner+w=401wt.eu-S1422731AbWLPWsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWLPWsT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWLPWsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:48:19 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:59780 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422731AbWLPWsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:48:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UNG5NnmxhVjmzgcFvFiVBAHAvBtH9mzUGbjWOGvgKMb7FAn5eeZsjBHNuV1Gmva4Dw87BQWq4lGe+weDSfk5gOlO+kCRKW2Ck3Gj4BoskfSqroBovcVSuf3ePduT/GaJa14L4LYKVSeYFu0Fk6EYDe+6i8Wj/VUEMYMnph+8sqQ=
Message-ID: <5a4c581d0612161448p450a0e16l5ed0f4f87999d0a5@mail.gmail.com>
Date: Sat, 16 Dec 2006 23:48:17 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.20-rc1-git4: drivers/connector/connector.c doesn't build due to work_struct changes
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/char/hangcheck-timer.o
  CC      drivers/clocksource/acpi_pm.o
  LD      drivers/clocksource/built-in.o
  CC [M]  drivers/connector/cn_queue.o
  CC [M]  drivers/connector/connector.o
drivers/connector/connector.c: In function 'cn_call_callback':
drivers/connector/connector.c:138: error: 'struct work_struct' has no
member named 'management'
drivers/connector/connector.c:138: error: 'struct work_struct' has no
member named 'management'
make[2]: *** [drivers/connector/connector.o] Error 1
make[1]: *** [drivers/connector] Error 2
make: *** [drivers] Error 2

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
