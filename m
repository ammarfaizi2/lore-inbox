Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264479AbRFLNmH>; Tue, 12 Jun 2001 09:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRFLNl5>; Tue, 12 Jun 2001 09:41:57 -0400
Received: from [195.6.125.97] ([195.6.125.97]:44817 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S264467AbRFLNlg>;
	Tue, 12 Jun 2001 09:41:36 -0400
Date: Tue, 12 Jun 2001 15:40:59 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: net.agent ?
Message-Id: <20010612154059.432b0279.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm porting a driver on 2.4. , I've done the necessary to get him working,
but 
when I read the logs I found something like this after doing that :

insmod my_module
ifconfig up my_module

>my_module : received ioctl 35585
>/etc/hotplug/net.agent : register event not handled

Somebody know how ensure that the ioctl call come from net.agent ?
Am I obliged to handle the ioctl for compatibilty or something else ?
coud I just ignore it ?

I'm using redhat 7.1 kernel 2.4.2

Thanks

sebastien person
