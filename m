Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVBHKzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVBHKzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVBHKzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:55:31 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:37295 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261511AbVBHKz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:55:26 -0500
Subject: Re: Touchpad problems with 2.6.11-rc2
From: Stephane Raimbault <stephane.raimbault@free.fr>
To: linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?St=E9phane?= Raimbault <stephane.raimbault@free.fr>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 11:55:58 +0100
Message-Id: <1107860158.5271.12.camel@picasso.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.6.11-rc3 + Peter's patch and xorg from Fedora Core 3, I
still have touchpad problems.
 
Tapping and focus work fine with 2.6.10 and 2.6.11-rc1 but not with :
- 2.6.11-rc2
- 2.6.11-rc3
I read a similar report on LKML from David Ford.
Only one tap on 30 is received and focus is really strange.

Like said in previous mails, small movements are rounded off to 0 but
the Peter Osterlund's patch resolves this problem (tested with rc3).

Hardware
kernel: input: AlpsPS/2 ALPS TouchPad on isa0 060/serio1
Vaio GRT916V

In my xorg.conf :
Driver      "mouse"
Option      "Protocol" "IMPS/2"

Bye,

Stephane Raimbault



