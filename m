Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVLZOjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLZOjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLZOjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 09:39:04 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:45164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbVLZOjC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 09:39:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=q1cWxVfSR1rgvIpWSr5KHdHfeqMR04PDZX+v/6lhXPm3DCoYCBY/qiJnJCocaZRwdLwcBncDFHvAbpi4If2KGB0QViWjr5gnHevA2sY6KeVucZcLFqJcQXl3hhgkkb+Qtj5ulIyF/l5aF97e+DeWMJD7eqS2RYTGmXnBMUVwGvU=
Date: Mon, 26 Dec 2005 15:38:52 +0100
From: Diego Calleja <diegocg@gmail.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: andrew.j.wade@gmail.com, vda@ilport.com.ua, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks
Message-Id: <20051226153852.05d5b047.diegocg@gmail.com>
In-Reply-To: <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
	<200512241403.38482.vda@ilport.com.ua>
	<200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 26 Dec 2005 02:42:51 -0500,
Andrew James Wade <andrew.j.wade@gmail.com> escribió:

> Ok, I've come up with a patch to "poison"/mark the kernel stacks with Qs
> when they're allocated. (I don't think it'll mark the IRQ stacks though).


How does this differs from CONFIG_DEBUG_STACKOVERFLOW?
