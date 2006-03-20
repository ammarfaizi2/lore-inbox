Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWCTG23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWCTG23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWCTG23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:28:29 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:25351 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751658AbWCTG22 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:28:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i9BZUSIfNjcHYTLNrVFG2iykBpDIlhy+uryE5wQbsvU99HOnyZd5MgWWHCRxUa1m3yXJrkFqBXKJna3cpxKGz05FypuoIeLBowRnmnky+kwFFaJ+LIG+8aUygPMQKBAKUmheJv7JnMxm0ewL13kSt/w+Xt4bRC5fB1WZcTcEYlw=
Message-ID: <b681c62b0603192228h2724f947l90bc6737048b56e@mail.gmail.com>
Date: Mon, 20 Mar 2006 11:58:26 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: writing to a device through driver entrypoint or directly from user space after mapping it
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If I want to write to a register of a PCI device which is in BAR
region, there are two ways:-
1) inside write() entrypoint of my driver, i can write to that
particular register.
2) if i have mapped my BAR region to user space, then writing to the
required register directly from user space.

So is there any difference in performance or time required to write to
a device from write() entrypoint of a driver or mapping a BAR region
to user space & then writing to it from user space?

are there any advantages / disadvantages ?

If i am wrong, correct me please.
Thanks in advance.
