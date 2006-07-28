Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWG1Kiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWG1Kiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWG1Kiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:38:50 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:56996 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932627AbWG1Kit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:38:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L5XmgejbrGjvlt9rqVs7A2NGtGN7wiQ7bWFj9qDBiYTtUDE5WeFOw3FBE8RPntarZm/XztemZ/2n2VEG6zjadX6ftQqanQVXh0u6yV+Fq8ABT+ZsEtvBz4o9sJ+TkKcXrJNLV5j4Mwiw7VmzK1Yj14uP4c9gEmmEyM8mpW+EThI=
Message-ID: <a44ae5cd0607280338x674aa92agb49f38a494bf8923@mail.gmail.com>
Date: Fri, 28 Jul 2006 12:38:49 +0200
From: "Miles Lane" <miles.lane@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Patrick McFarland" <diablod3@gmail.com>,
       "Miles Lane" <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
In-Reply-To: <20060728011040.GO5687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
	 <200607272104.24088.diablod3@gmail.com>
	 <20060728011040.GO5687@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Dave Jones <davej@redhat.com> wrote:
> On Thu, Jul 27, 2006 at 09:04:23PM -0400, Patrick McFarland wrote:
>
>  > I think you've gotten confused. Ondemand is a horrible governor that only
>  > flips between two cpu frequencies, the lowest and the highest.
>
> That isn't true.  I just double checked, and saw my core-duo changing
> between all 4 states it offers.

Yep, the ondemand governor switches between all frequencies on my
Pentium 4 M laptop.  It's a HP Pavillion dv1240us.

>  > Use the Conservative governor instead.
>
> This governor is based on the same code as on-demand with some subtle
> tweaks to make it not change the frequency as often.  If anything *this*
> one should be less 'active' for you than ondemand.

I have tried the other governers (albeit a while ago) and found they
didn't manage power anywhere near as well as ondemand.  Perhaps
results vary for each governor according to CPU and chipset.

      Miles
