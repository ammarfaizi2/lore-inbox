Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWE3MVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWE3MVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWE3MVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:21:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:19797 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932258AbWE3MVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:21:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IF9nuHE1GtsvE7hT3shU8wPfkhfCTClTq+BlaLoqWfwKRKMW6BI0TYPCeoSXBve07ExfukgYYxsbQrNnsE65senMPmYj3aRkm554m5oAy4ezihMtyd6n1GdhaDHsWPAH51/VxvC+UcuHo+B1mVVjopKL6jgcXGGjpn7q21Q98js=
Message-ID: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
Date: Wed, 31 May 2006 00:21:53 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IO APIC IRQ assignment
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We are working closely with an x86-based hardware manufacturer for our
linux based application. In their hardware, it contains 4 x BT878
chips and 3 x USB controllers. The USB and BT878 share the same
hardware IRQ lines, which is causing us to notice random hard lockups.
Increasing the PCI latency of the BTTV drivers has helped the
situation (we have not noticed any lockups yet), but it would be nice
if we can separate the IRQs.

We asked the manufacturers if they can do a physical modication for
us, but unfortunately this is not possible. The engineer did mention
that under Windows XP in "IO APIC" mode, it is possible to assign
different IRQs to the USB and BTTV.

Is this possible in Linux? We have tried enabling IO APIC in the
kernel, but the IRQs are still shared.

Please advise if it is even possible in Linux to achieve what we want.

Kind Regards
Keith
