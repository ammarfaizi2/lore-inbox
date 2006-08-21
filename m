Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWHUQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWHUQqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWHUQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:46:35 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:50378 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964990AbWHUQqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:46:35 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
Date: Tue, 22 Aug 2006 02:46:27 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <tkoje25hlbjo1ui9i9v86fpdl6h4sfjnpq@4ax.com>
References: <44E8C9AE.3060307@gmail.com> <20060821023017.GA30017@jupiter.solarsys.private> <20060821111127.fe93bc0a.khali@linux-fr.org>
In-Reply-To: <20060821111127.fe93bc0a.khali@linux-fr.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 11:11:27 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Mark, Michal,
>
>> Thanks for doing this... but Andrew please don't apply it.  The sensors project
>> people are working on these even now, and we already have a patch for the
>> w83627hf driver...
>> 
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
>> 
>> Jean Delvare (hwmon maintainer) should be sending these up the chain soon.
>> 
>> Michal: if you're interested in fixing any of the rest of them, please take
>> a look at the patch above to see the mechanism we intend to use.  It actually
>> makes the drivers *smaller* than they were.
>
>The size change really depends on the driver. For older drivers with
>individual file registration (sometimes hidden behind macros) the
>driver size will indeed shrink, but for newer drivers with loop-based
>file registration, this would be a slight increase in size. Not that it
>really matters anyway, what matters is that we handle errors and file
>deletion properly from now on.
>
>Michal, if you go on working on this (and this is welcome), please
>follow what Mark did, as this is what we agreed was the best approach.
>Here is a quick status summary for drivers/hwmon:
>
...
> o adm9240

Somebody else is welcome to do this one, my last patch was dropped.

Grant.
