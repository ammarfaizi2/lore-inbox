Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281062AbRKTVsQ>; Tue, 20 Nov 2001 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281068AbRKTVsH>; Tue, 20 Nov 2001 16:48:07 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:45499 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S281062AbRKTVrz>;
	Tue, 20 Nov 2001 16:47:55 -0500
Date: Tue, 20 Nov 2001 22:47:53 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
Message-ID: <20011120224753.A29777@se1.cogenit.fr>
In-Reply-To: <20011118145400.A23181@se1.cogenit.fr> <E166HcS-0001lw-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E166HcS-0001lw-00@calista.inka.de>; from ecki@lina.inka.de on Tue, Nov 20, 2001 at 09:35:48PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki@lina.inka.de> :
> In article <20011118145400.A23181@se1.cogenit.fr> you wrote:
> > Think about forwarding between GigaE and FastE. Think about overflow and
> > bad irq latency. I wouldn't cut buffering at l2 as it averages the peaks. 
> > Different trade-offs make sense of course.
> 
> I think in that case increasing the buffers is important:
> 
> net.core.rmem_max=262144
> net.core.wmem_max=262144

Aren't these only useful to userspace apps ?

-- 
Ueimor
