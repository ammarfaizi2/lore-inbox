Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbRFFNvB>; Wed, 6 Jun 2001 09:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbRFFNuv>; Wed, 6 Jun 2001 09:50:51 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:62981 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S263172AbRFFNuk>;
	Wed, 6 Jun 2001 09:50:40 -0400
Message-ID: <20010606155026.A28950@bug.ucw.cz>
Date: Wed, 6 Jun 2001 15:50:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: "David N. Welton" <davidw@apache.org>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
In-Reply-To: <87snhdvln9.fsf@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <87snhdvln9.fsf@apache.org>; from David N. Welton on Wed, Jun 06, 2001 at 02:27:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [ please CC replies to me ]
> 
> Perusing the kernel sources while investigating watchdog drivers, I
> notice that in some places, Fahrenheit is used, and in some places,
> Celsius.  It would seem logical to me to have a global config option,
> so that you *know* that you talk devices either in F or C.

Please, don't.

Use kelvins *0.1, and use them consistently everywhere. This is what
ACPI does, and it is probably right.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
