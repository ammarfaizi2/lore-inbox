Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281811AbRLQSUr>; Mon, 17 Dec 2001 13:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRLQSUh>; Mon, 17 Dec 2001 13:20:37 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:34067 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S281811AbRLQSU1>; Mon, 17 Dec 2001 13:20:27 -0500
Subject: [Alpha/Linux ] Stack layout/and register values for
	ret_from_sys_call
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 23:50:57 +0530
Message-Id: <1008613257.22228.3.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 Can someone explain me what should be the stack layout and register
value( if there is any restriction ) before calling ret_from_syscall for
Alpha. Again in entry.S i find may places where  we make current (
Register 8) as below 

  lda     $8,0x3fff
  bic     $30,$8,$8

If someone can expain what happens in the above two assembly statement
it will be really helpful.

Thanks in advance. 

-aneesh 

  




