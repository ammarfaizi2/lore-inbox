Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUABHIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUABHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:08:10 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:22659 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265169AbUABHHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:07:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics 3button emulation hosed in 2.6.0-mm2
Date: Fri, 2 Jan 2004 02:07:39 -0500
User-Agent: KMail/1.5.4
References: <1073024655.2516.11.camel@mentor.gurulabs.com>
In-Reply-To: <1073024655.2516.11.camel@mentor.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401020207.39713.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 01:24 am, Dax Kelson wrote:
> Brief summary: 3 button emulation very flaky
> Linux: Fedora with 2.6.0-mm2
> Laptop: Dell Inspiron 4150
>
> ----------------------------
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> synaptics reset failed
> synaptics reset failed
> synaptics reset failed

First off do not use ACPI PM timer...

Also, could you please tell me if it's X or GPM and what's in your "InputDevices"
section of XFConfig and what parameters are you passing to GPM.

Thank you,

Dmitry
