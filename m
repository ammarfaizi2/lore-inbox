Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWH3PMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWH3PMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWH3PMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:12:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:35434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750993AbWH3PMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:12:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Znh2mBtPjzsu0sO3vnW6qlVYdsqF0xj4PXEPU5cPSnGqMPrCChZtACBoUFIKF+fUksgPuvr5Hb5bHsDVTupD8rv9ujdBvDlBGmkJcyOrF3BhUDQ1U8LdNNqjZ3ll3dt3PXM1G+kusjxpVV6z7nCoMgVgtJpc8JxeZB594OSO/jE=
Message-ID: <7783925d0608300812j2175164dja401b4e763a5ac43@mail.gmail.com>
Date: Wed, 30 Aug 2006 20:42:14 +0530
From: "Rick Brown" <rick.brown.3@gmail.com>
To: linux-newbie@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Interrupt handler registration for multiple devices
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to write a driver that will handle multiple devices. These
devices will share the IRQ line. Do I need to register my (same)
interrupt handler as many times as the number of devices(by calling
request_irq())?

Also an unrelated query. Can I sleep after a call to preempt_kernel()??

TIA,

Rick
