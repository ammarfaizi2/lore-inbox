Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTK3W2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTK3W2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:28:18 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:2135 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261567AbTK3W2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:28:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Date: Sun, 30 Nov 2003 17:28:10 -0500
User-Agent: KMail/1.5.4
References: <20031130214612.GP2935@mail.muni.cz>
In-Reply-To: <20031130214612.GP2935@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301728.10563.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 November 2003 04:46 pm, Lukas Hejtmanek wrote:

> Nov 30 12:32:23 debian kernel: Synaptics driver resynced.
> Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
> Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
> Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 1st byte
> Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
> Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 1st byte
> Nov 30 12:33:54 debian last message repeated 2 times
> Nov 30 12:33:54 debian kernel: Synaptics driver resynced.
> Nov 30 12:34:25 debian kernel: Synaptics driver lost sync at 1st byte
>
>
> It does not happen with 2.4.22 kernel. Is there something I can try?

Hi,

Are you using ACPI? Does it work without ACPI? Do you have an application
that periodically polls battery state or temperature? From what I've seen
many laptops spend considerable amount of time in BIOS when checking
battery state...

Dmitry
