Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVC3Sda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVC3Sda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVC3Sda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:33:30 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:23849 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262377AbVC3Sd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:33:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Zvw25bVJ70N1tAGxWT7uIfKVWzCHUh2lXVIN3bVLTBgvZaxTcAFItl2142I76dKHzFJoKjfTF4AWycvJKAfKAQfxHOkfQzYslNTNQqQdPLChJEXVC1nOkeAtMqyBg6layg+T4ZyH2sddAAqkhGH6wf1Hortcb659iZE7zV1VxyY=
Message-ID: <9e473391050330103379e398de@mail.gmail.com>
Date: Wed, 30 Mar 2005 13:33:24 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: krishna <krishna.c@globaledgesoft.com>
Subject: Re: How to debug kernel before there is no printk mechanism?
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <424AD247.4080409@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <424AD247.4080409@globaledgesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try turning on CONFIG_EARLY_PRINTK=y? That will allow printk
to a serial console much earlier.

You need to build the serial driver in too:
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

-- 
Jon Smirl
jonsmirl@gmail.com
