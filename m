Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTFXXsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFXXsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:48:35 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:37257 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263355AbTFXXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:48:30 -0400
Message-ID: <3EF937FA.1090300@free.fr>
Date: Wed, 25 Jun 2003 07:49:46 +0200
From: Olivier Fauchon <olivier.fauchon@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: suspend on ram ... LCD & backlight restore problem. 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried suspend on ram on my VAio FX 801 & kernel 2.5.69,

with echo "3" > /proc/acpi/sleep

That works great, system goes to sleep and red light blinking.

But When i try to resume, i can see the display coming back for a few 
milliseconds, and then LCD goes black & backlight turns off.

I'm sure the kernel is correctly restored because i run commands like 
locate -u or reboot in "blind mode", so my problem is the video mode 
restoring.

if i try acpi_sleep=s3_bios, i get blacklight on & LCD all white.

Do you have ideas on what can cause this strange behaviour. any comments 
welcome

NB: my vaio pass blacklist test at boot up

thanks.

Olivier Fauchon




