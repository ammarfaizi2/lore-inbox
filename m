Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRCVRZR>; Thu, 22 Mar 2001 12:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRCVRZI>; Thu, 22 Mar 2001 12:25:08 -0500
Received: from [217.27.32.7] ([217.27.32.7]:1307 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S132113AbRCVRYx>;
	Thu, 22 Mar 2001 12:24:53 -0500
Date: Thu, 22 Mar 2001 19:23:26 +0200
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: Marco Calistri <ik5bcu@tin.it>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: 2.2.18-modules belonging?
Message-ID: <20010322192326.A6437@francoudi.com>
In-Reply-To: <XFMail.20010322174115.ik5bcu@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010322174115.ik5bcu@tin.it>; from ik5bcu@tin.it on Thu, Mar 22, 2001 at 05:41:15PM +0100
X-Operating-System: Linux leonid.francoudi.com 2.4.3-pre6
X-Uptime: 7:12pm  up  8:13, 11 users,  load average: 0.21, 0.23, 0.52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco Calistri,

Once you wrote about "2.2.18-modules belonging?":
MC> Hello,I'am going into these problems:
MC> 
MC> Mar 22 10:24:15 linux modprobe: modprobe: Can't locate module sound-slot-0
MC> Mar 22 10:24:15 linux modprobe: modprobe: Can't locate module sound-service-0-0
MC> 
MC> Wonder the above modules belong to which SOUND_CONFIGURE.
MC> 
MC> I'am using 2.2.18 and playmidi runs ok but RealPlayer reports
MC> that could not open audio device :resource is busy.

In your /etc/modules.conf (or /etc/conf.modules) add following lines:
alias sound-slot-0 yoursoundmodule
alias sound-service-0-0 yoursoundmodule

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator

