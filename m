Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTLWQ6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLWQ6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:58:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262050AbTLWQ5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:57:44 -0500
Date: Tue, 23 Dec 2003 11:57:39 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: various issues with ACPI sleep and 2.6
Message-ID: <20031223165739.GA28356@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing ACPI sleep under 2.6, I noticed the following issues
(Thinkpad T40, i855PM chipset):

- USB fails on resume (sent to linux-usb-devel)
- DRI being loaded at all causes X to fail on resume
- MCE on resume:

 MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 Bank 1: f200000000000175
 
Are these known issues, or 'features' of suspend on this ACPI
bios?

Bill
