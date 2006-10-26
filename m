Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423053AbWJZJyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbWJZJyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbWJZJyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:54:09 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:55279 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1423053AbWJZJyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:54:07 -0400
Subject: usb initialization order (usbhid vs. appletouch)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 11:53:58 +0200
Message-Id: <1161856438.5214.2.camel@no.intranet.wo.rk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I've noticed that the appletouch driver needs to be loaded *before* the
usbhid driver to function. This is currently impossible when built into
the kernel (and not modules). So I wonder how one can change the
ordering of when the usb drivers are loaded.

Suggestions ?

Soeren
-- 
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962
