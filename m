Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRCGUJd>; Wed, 7 Mar 2001 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131179AbRCGUJS>; Wed, 7 Mar 2001 15:09:18 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53129 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131168AbRCGUIp>;
	Wed, 7 Mar 2001 15:08:45 -0500
Message-ID: <3AA6951B.45FDBC1B@mandrakesoft.com>
Date: Wed, 07 Mar 2001 15:07:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Fremlin <chief@bandits.org>
Cc: linux-kernel@vger.kernel.org, thood@excite.com
Subject: Re: Forcible removal of modules
In-Reply-To: <9038100.983917051702.JavaMail.imail@digger.excite.com> <m2vgpltkrh.fsf@boreas.yi.org.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> Why not set up the device driver to handle PM events itself. See
> Documentation/pm.txt under Driver Interface.

For PCI drivers, you implement the ::suspend and ::remove hooks.

> I have a race free version of pm_send_all if you want it.

Is this the same thing that is in 2.4.3-pre3?

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
