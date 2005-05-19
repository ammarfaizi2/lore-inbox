Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVESG6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVESG6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVESG6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:58:14 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:6679 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262435AbVESG6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:58:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=et0guOfjrXE/0h9SCwlJeAlRQlKk8g/vJqvJgnBF0ghVR5SOsmjJVR44q5SPz01OV1ZElVuOnJMR6n/UUW2pALY49Ecf07BCKsFjDCrkodciXJNsV2c9TxalkmQjOMViyMj/7gVd72r3bVjA5ltfwCOiM5WofeYE5ILaeeHpjn0=
Message-ID: <377362e1050518235812f1cbbb@mail.gmail.com>
Date: Thu, 19 May 2005 15:58:07 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505190756.16413.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <377362e10505181142252ec930@mail.gmail.com>
	 <200505190756.16413.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> ------------snip---------------
> Hyperthread sibling cpus share cpu power. If you let a nice 19 task run full
> power on the sibling cpu of a nice 0 task it will drain performance from the
> nice 0 task and make it run approximately 40% slower. The only way around
> this is to temporarily make the sibling run idle so that a nice 0 task gets
> the appropriate proportion of cpu resources compared to a nice 19 task. It is
> intentional and quite unique to the linux cpu scheduler as far as I can tell.
> On any other scheduler or OS a nice 19 "background" task will make your
> machine run much slower.
> 
> Cheers,
> Con
> 

Thanks.   I understood it's a feature of linux kernel and am satisfied
with it.  Actually on Windows xp my application sometimes slows down
maybe due to inpropoer scheduler.

-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
