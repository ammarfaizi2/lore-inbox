Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272407AbRIRP5D>; Tue, 18 Sep 2001 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272417AbRIRP4x>; Tue, 18 Sep 2001 11:56:53 -0400
Received: from sirene.rz.uni-duesseldorf.de ([134.99.128.2]:21122 "EHLO
	sirene.rz.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S272407AbRIRP4m>; Tue, 18 Sep 2001 11:56:42 -0400
Date: Tue, 18 Sep 2001 19:27:05 +0330 (GMT+03:30)
From: Knut.Neumann@rz.uni-duesseldorf.de
Subject: SonyPI Driver
To: linux-kernel@vger.kernel.org
Message-id: <530970805.1000828625163.JavaMail.root@localhost>
MIME-version: 1.0
X-Mailer: Sun(TM) Web Access 1.2
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I noticed that when running the sonypi driver on my VAIO z600tek, APM Suspend does no longer work: The power button (to suspend) does no longer work and - well - it will still suspend if I force it to, by apm -s but it does not resume (powers on, but blank screen and no input gets processed).

The system is a vaio z600tek with debian potato and kernel 2.4.9 apm compiled in and enabled at boot time. Its also patched with ext3 patch and latest acpi-patch (though acpi is disabled at boot). I as well observed this behaviour with a non-acpi-patched kernel. Sonypi is compiled as module and the system will correctly suspend and resume as long as the module is not loaded. After it has been loaded once, the system will no longer resume from suspend.

I assume that is because the driver is mainly based on acpi-functionality (and thus reverse engineering), but I am not quite sure. 

If anyone has an idea, please let me know (and please cc: to me as I am not subscribed to the list)

Thank you very much in advance.

-Knut

knut.neumann@uni-duesseldorf.de 
