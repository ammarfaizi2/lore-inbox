Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVARWWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVARWWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVARWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:22:12 -0500
Received: from mail.inter-page.com ([207.42.84.180]:36363 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261448AbVARWWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:22:08 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <linux-os@analogic.com>, "'john stultz'" <johnstul@us.ibm.com>
Cc: "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: New Linux System time proposal
Date: Tue, 18 Jan 2005 14:21:38 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAo+V6scX9e0yTLGWCQJDW1QEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.61.0501111548400.3354@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it was not at all unusual to miss a jiffy here or there due to interrupt
locking/latency; plus jiffies is expressed with respect to the value of HZ so you
would need to do some deviding in there somewhere.

Where HZ has been adjusted up, or on slower embedded boxes where interrupts could be
blocked longer, you would lose time.

Or are you not talking about real-word time?

Rob White,
Casabyte, Inc.

