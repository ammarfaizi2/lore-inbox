Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288354AbSACW1M>; Thu, 3 Jan 2002 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288353AbSACW1F>; Thu, 3 Jan 2002 17:27:05 -0500
Received: from [217.200.20.72] ([217.200.20.72]:30605 "HELO
	markolaptop.markoer.net") by vger.kernel.org with SMTP
	id <S288336AbSACW0u>; Thu, 3 Jan 2002 17:26:50 -0500
Date: Thu, 3 Jan 2002 23:26:14 +0100
From: Marco Ermini <markoer@markoer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-Id: <20020103232614.26f2f5af.markoer@markoer.org>
In-Reply-To: <Pine.LNX.4.33.0201010152190.3557-100000@localhost.localdomain>
In-Reply-To: <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
	<Pine.LNX.4.33.0201010152190.3557-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Markoer's secret spy software - your computer is under my control!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002 02:00:01 -0500 (EST), Werner Puschitz
<werner.lx@verizon.net> wrote:

[...]
> I'm having the exact same problems on my ThinkPad 390X. Sometimes it
> freezes several times a day with the exact same symptoms. RedHat 6.2
> worked fine on this laptop. The problems started with 7.1 which uses 
> XFree86 4.0, and it didn't get better with 7.2 (XFree86 4.1).
> What makes it even worse is that after a warm reboot, the screen and 
> keyboard locks up again as soon as gdm gets started (Numlock doesn't work 
> etc.). So I always have to turn off the power to get the laptop working 
> again.

A similar things happened to me. I have a Toshiba Satellite 4080 XCDT, and
switching from XFree to console and back to XFree becomed impossibile with the
upgrade to Redhat 7.x and XFree 4. The problem is that the apm script use to
switch to console mode when I suspend (es. closing the laptop) and when it
resumes it tries to switch to XFree again, but this messes the screen. I am
still able to come back to console and killall X, but of course I'll lose my
current not saved works under X.

Under XFree 3 I could switch from X to console and back without problems -
anyway, after a couple of switches my laptop used to hang. I think X writes to
the uncorrect memory regions causing my laptop to hang.


ciao

-- 
Marco Ermini
http://www.markoer.org
Perche' perdere tempo ad imparare quando l'ignoranza e' istantanea? (Hobbes)
