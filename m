Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWG1BYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWG1BYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWG1BYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:24:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:65156 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751765AbWG1BYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:24:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ndfQsOpO0P7g1XQpPhC+hRUyzHHfGQOwSlbEd2op/+CTNVR3RH9zfKurGCr11XvO9df5aqmoCfM4PMtQ08VcGzczT9oMFd7WyxCkwzeUmrqVQyhq8Wona5T/X2JoLvICH270lKfQ/862R69YpdF1aKxfGXAwFXx7j/LcwJtj7ro=
From: Patrick McFarland <diablod3@gmail.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
Date: Thu, 27 Jul 2006 21:25:16 -0400
User-Agent: KMail/1.9.1
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com> <200607272104.24088.diablod3@gmail.com> <20060728011040.GO5687@redhat.com>
In-Reply-To: <20060728011040.GO5687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607272125.17051.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 21:10, Dave Jones wrote:
> On Thu, Jul 27, 2006 at 09:04:23PM -0400, Patrick McFarland wrote:
>  > I think you've gotten confused. Ondemand is a horrible governor that
>  > only flips between two cpu frequencies, the lowest and the highest.
>
> That isn't true.  I just double checked, and saw my core-duo changing
> between all 4 states it offers.

This may have been fixed then.

>  > Use the Conservative governor instead.
>
> This governor is based on the same code as on-demand with some subtle
> tweaks to make it not change the frequency as often.  If anything *this*
> one should be less 'active' for you than ondemand.

This used to be not true at all. Go back in the LKML archives about a year or 
so.

> What driver are you using ?

K7.

> 		Dave

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

