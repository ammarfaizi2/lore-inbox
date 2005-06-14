Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFNFhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFNFhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVFNFhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:37:14 -0400
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:29577 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261215AbVFNFhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:37:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adam Morley <adam.morley@gmail.com>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Date: Tue, 14 Jun 2005 00:37:04 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <b70d73800506051924546c8931@mail.gmail.com> <b70d738005060821032cc1a4a@mail.gmail.com> <b70d738005061322223fc7942@mail.gmail.com>
In-Reply-To: <b70d738005061322223fc7942@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506140037.05242.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 00:22, Adam Morley wrote:
> Hi All,
> 
> I hadn't heard anything from Dimitry in a few days, so I thought I'd
> resend and see if anyone else had any pointers for where I should
> look.  I'd still love to have a functional mouse post-mem suspend.
>

Unfortunately I don't have any ideas so far why your mouse does not
want to respond, it looks the kernel tries to do the right thing...

What we could try is to force PNP layer to re-enable the device, but
I don't have code for that yet.

-- 
Dmitry
