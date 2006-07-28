Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWG1BEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWG1BEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWG1BEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:04:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:3705 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750972AbWG1BEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:04:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jy4Wls246eIiHB8+obYYRTuYPofk3iTQ4QDSlu1R+9jsAWJbqnHC3mgPhgH/FuNnv22il5bBr6R711NctktOZtRk2tZA1hXUCV37q5x/z9bHxcmyQDVzfIkcDHCZpm7IFZff56m+cMS9k42t6UiZLp2ToIB3JMhKhjWf1Frsc18=
From: Patrick McFarland <diablod3@gmail.com>
To: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
Date: Thu, 27 Jul 2006 21:04:23 -0400
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
In-Reply-To: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607272104.24088.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 04:54, Miles Lane wrote:
> Hello,
>
> It sounds, from comments in the discussion of CPU Hotplug locking
> problems, as though you are considering deleting the ondemand CPUFreq
> code.  If this happens, I hope that something that provides the same
> functionality replaces it.  I really appreciate having my power
> consumption automatically modulated on an as needed basis.  Power
> management seems to be one of the areas where there is a lot of room
> for improvement.

I think you've gotten confused. Ondemand is a horrible governor that only 
flips between two cpu frequencies, the lowest and the highest. Use the 
Conservative governor instead.

Also, the locking issues have nothing to do with Ondemand, its just that 
Ondemand's suckyness came up in the thread.

> Thanks,
>       Miles

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

