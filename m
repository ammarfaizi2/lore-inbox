Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281358AbRKTUgI>; Tue, 20 Nov 2001 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281360AbRKTUf7>; Tue, 20 Nov 2001 15:35:59 -0500
Received: from quechua.inka.de ([212.227.14.2]:13588 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281358AbRKTUft>;
	Tue, 20 Nov 2001 15:35:49 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
In-Reply-To: <20011118145400.A23181@se1.cogenit.fr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E166HcS-0001lw-00@calista.inka.de>
Date: Tue, 20 Nov 2001 21:35:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011118145400.A23181@se1.cogenit.fr> you wrote:
> Think about forwarding between GigaE and FastE. Think about overflow and
> bad irq latency. I wouldn't cut buffering at l2 as it averages the peaks. 
> Different trade-offs make sense of course.

I think in that case increasing the buffers is important:

net.core.rmem_max=262144
net.core.wmem_max=262144

default:

optmem_max:10240
rmem_default:65535
rmem_max:65535
wmem_default:65535
wmem_max:65535

Greetings
Bernd
