Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283884AbRLABwM>; Fri, 30 Nov 2001 20:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283885AbRLABvx>; Fri, 30 Nov 2001 20:51:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:37616 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283884AbRLABvu>; Fri, 30 Nov 2001 20:51:50 -0500
Message-ID: <3C083794.2D6C8825@mvista.com>
Date: Fri, 30 Nov 2001 17:51:16 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Garst R. Reese" <reese@isn.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: small feature request
In-Reply-To: <3C0822EB.3E4C4852@isn.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Garst R. Reese" wrote:
> 
> Would it possible to put a header on System.map indicating the kernel
> version?
> Sometimes my little brain forgets what kernel System.old is for.
> Thanks, Garst
> -
Just name it: System.map.2.4.16-xx (where xx is the build number)  This
is easy to automate in your install script.  Then real system map is "ln
-s"ed to the correct file.

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
