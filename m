Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280591AbRKSSqV>; Mon, 19 Nov 2001 13:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280599AbRKSSqK>; Mon, 19 Nov 2001 13:46:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27638 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S280592AbRKSSo1>; Mon, 19 Nov 2001 13:44:27 -0500
Message-ID: <3BF952EC.6C8DB2BD@mvista.com>
Date: Mon, 19 Nov 2001 10:43:56 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Jasen <jjasen1@umbc.edu>
CC: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
        linux-kernel@vger.kernel.org
Subject: Re: Hp 8xxx Cd writer
In-Reply-To: <Pine.SGI.4.31L.02.0111191108260.12469772-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> 
> On Mon, 19 Nov 2001, Miguel Maria Godinho de Matos wrote:
> 
> > I have a doubt though! I have an externel cd-writer ( hp 8200 ) which is
> > supported by the kernel, but in the make xconfig menu, that options appears
> > in gray ( u can't select it ). As a lot of kernel options need some kind of
> > pre-selected items, i am asking anyone who  knows what do i have to
> > pre-select so i can choose the module for hp..... support in my usb kernel
> > configuration menu.
> 
> You probably need to say yes to experimental drivers, and if I recall the
> HP8200 correctly, various USB options.
> 
I really don't know, BUT, questions of this sort can be answered by
looking at the Config.in file.  Its root will be found in .../arch/your
arch/Config.in.  It may include (source) other files which may in turn
source still more, but in there is the whole of the configuration with
all it options.  The syntax is really quite easy to follow.  Have fun.
-- 
George           george@mvista.com  (fishing lessons, not fish)
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
