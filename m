Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVJYBL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVJYBL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVJYBL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:11:26 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:23437 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751367AbVJYBL0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:11:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dFFY4wdV+1K+6l8j8seD8Ad+7ZIrB8bUKYHmEcZxHKFQypzrXsmcoZvdzaHzTVNBic87lm6OKEqm9XN1BENgxD721EafDHbFBanN/US8PUPeBi/we4ODtfarv0LzNHdWkJSYNXENpGtgNFrex1zeHcCz+PEXo8B9laZiveTnH+s=
Message-ID: <86802c440510241811w6e3c6d77o3a5e1ca8ad20900a@mail.gmail.com>
Date: Mon, 24 Oct 2005 18:11:23 -0700
From: Yinghai Lu <yinghai.lu@amd.com>
To: Andi Kleen <ak@suse.de>
Subject: x86_64: 2.6.14 machine_emergency_restart
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

in arch/x86_64/kernel/reboot.c , machine_emergency_restart,

why it need to loop 100 times...? it could hold the restart for 10 seconds

YH
