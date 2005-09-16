Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbVIPE6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbVIPE6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVIPE6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:58:04 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:46927 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030595AbVIPE6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:58:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
Date: Thu, 15 Sep 2005 23:57:58 -0500
User-Agent: KMail/1.8.2
Cc: Tim Rupp <caphrim007@gmail.com>
References: <432A4A1F.3040308@gmail.com>
In-Reply-To: <432A4A1F.3040308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152357.58921.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 23:29, Tim Rupp wrote:
> I just recently went to upgrade to 2.6.13 from 2.6.12.3 and after
> re-compiling with a clean .config, I've hit a snag.
> 
> I'm pretty sure I've got the config script down right, but upon reboot,
> I no longer have a keyboard.
> 
> I checked to see if this had crept up between 2.6.12.3 and 2.6.13.1. It
> seems that >2.6.13 are the versions that do this.
> 
> Attached are dmesgs from my 2.6.13.1 and 2.6.12.3 kernels. In the
> 2.6.13.1 kernel I noticed this line.
> 
> 	i8042.c: Can't read CTR while initializing i8042
> 

The kernel failed to talk to your keyboard controller. Try booting with
"usb-handoff" and also try "acpi=off"

-- 
Dmitry
