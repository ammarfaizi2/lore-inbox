Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbUJZLan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUJZLan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUJZLan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:30:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7126 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262231AbUJZLai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:30:38 -0400
Date: Tue, 26 Oct 2004 13:30:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arne Henrichsen <ahenric@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with close() system call
In-Reply-To: <605a56ed04102504401e0f469f@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0410261329410.26803@yvahk01.tjqt.qr>
References: <605a56ed04102504401e0f469f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I have a question regarding the close() system call. I have written my
>own character driver for a serial type card with 8 ports. [...]
>somehow a close system
>call has been initiated (not called by my user app).

Best is to put a printk("i'm in ioctl()") in the ioctl() function and a
printk("i'm in close()") in the close() one, to be really sure whether the
close() function of your module is called.

>

Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
