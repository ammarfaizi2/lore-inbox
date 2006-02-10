Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWBJTUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWBJTUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWBJTUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:20:36 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:27922 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750959AbWBJTUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:20:35 -0500
Message-ID: <43ECE734.5010907@cfl.rr.com>
Date: Fri, 10 Feb 2006 14:19:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re:
 CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring
 up a hornets' nest) ]]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org>
In-Reply-To: <20060210175848.GA5533@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 19:21:18.0761 (UTC) FILETIME=[2B366990:01C62E77]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14259.000
X-TM-AS-Result: No--1.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> I just tried blanking a CD-RW with the latest -git tree. The machine just became
> unresponsive and then froze. When it became unresponsive the clock in GNOME still
> displayed the current time but I could not focus any windows anymore. Then I had
> to hard reboot the machine. The logs say nothing. I repeat: nothing.
>
> Does anyone have similar problems?

Instead of rebooting, just wait for the blanking to finish.  My guess is 
that your burner and hard drive are both on the same ide channel, and so 
you can not access the disk while the burner is blanking.  If this is 
the case, put each drive on their own ide channel. 


