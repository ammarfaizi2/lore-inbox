Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVCVJDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVCVJDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVCVJDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:03:04 -0500
Received: from one.firstfloor.org ([213.235.205.2]:43701 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262577AbVCVJCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:02:51 -0500
To: Sean Russell <ser@ser1.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[01] freeze on x86_64
References: <423F5152.2010303@ser1.net>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Mar 2005 10:02:47 +0100
In-Reply-To: <423F5152.2010303@ser1.net> (Sean Russell's message of "Mon, 21
 Mar 2005 17:57:22 -0500")
Message-ID: <m13buo3vew.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Russell <ser@ser1.net> writes:


> appear to be related to the lockup.  In my logs, the last message
> before the crash is always (that I've noticed) an ACPI error:
>
>     acpi_thermal-0400 [23] acpi_thermal_get_trip_: Invalid active
> threshold [0]

You mean you got this in /var/log/messages?

Can you connect a serial console or netconsole and see if that 
catches anything?  Also boot with oops=panic

-Andi
