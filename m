Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTJPNR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJPNR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:17:29 -0400
Received: from [203.199.54.175] ([203.199.54.175]:21778 "EHLO
	MailRelay.lntinfotech.com") by vger.kernel.org with ESMTP
	id S262906AbTJPNR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:17:28 -0400
Subject: Interrupt handling
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
From: "Sanil K" <Sanil.K@lntinfotech.com>
Date: Thu, 16 Oct 2003 18:46:02 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 10/16/2003 06:46:05 PM,
	Itemize by SMTP Server on MailRelay/LNTINFOTECH(Release 5.0.12  |February
 13, 2003) at 10/16/2003 07:00:57 PM,
	Serialize by Router on MailRelay/LNTINFOTECH(Release 5.0.12  |February 13, 2003) at
 10/16/2003 07:01:13 PM,
	Serialize complete at 10/16/2003 07:01:13 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This may be a generic problem as far as a driver is concerned.

We need to handle an interrupt and inform the user space on the event and
pass the data correspodning to the event.

The event can be informed through SIGNAL and the signal handler can be
invoked in the user space. Then again for data, we need to have the
"copy_to_user" mechanism .

Is there any other effective mechanism(s) to handle the interrupt. I mean
we need to convey the event and or data to the user space(prefer -
asynchronously).

Please share your views.

Sanil.

