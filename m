Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268113AbTBRXi0>; Tue, 18 Feb 2003 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268114AbTBRXi0>; Tue, 18 Feb 2003 18:38:26 -0500
Received: from smtp.terra.es ([213.4.129.129]:1174 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id <S268113AbTBRXiZ> convert rfc822-to-8bit;
	Tue, 18 Feb 2003 18:38:25 -0500
Date: Wed, 19 Feb 2003 00:47:28 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Re: buggy include path?
Message-Id: <20030219004728.37c9f3bd.diegocg@teleline.es>
In-Reply-To: <20030219002938.08b717c7.diegocg@teleline.es>
References: <20030219002938.08b717c7.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El día Wed, 19 Feb 2003 00:29:38 +0100
Arador <diegocg@teleline.es> escribió...

> Including include/usb.h from a external module source (out of the kernel tree) causes 
> this:
> In file included from /home/diego/kernel/unsta/include/linux/irq.h:19,
>                  from /home/diego/kernel/unsta/include/asm/hardirq.h:6,
>                  from /home/diego/kernel/unsta/include/linux/interrupt.h:9,
>                  from /home/diego/kernel/unsta/include/linux/usb.h:15, <- file included
>                  from w9968cf.h:38,
>                  from w9968cf.c:57:
> /home/diego/kernel/unsta/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory

of course, w9968cf.c just includes <include/usb.h>, with -I/home/diego/kernel/unsta/include


Diego Calleja
