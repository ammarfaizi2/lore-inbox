Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWEWVID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWEWVID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWEWVID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:08:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:12847 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932273AbWEWVIC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:08:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNbbknJLJAVK3onYL8HvCR3HPeP5Kmh+Mng/Ysr8WOcCIUvUblU01FkOCVVtObJrK86Zr7E6GEL86Xe5U5ixBIAGvLwf7GoeHcCB5m5SwgJ+ElSCTrOdasTwy28/Xc6ZWo2HoU9Kc9ETT+QEW7qVsADYANVo+D8+iazwj6FwnmY=
Message-ID: <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
Date: Tue, 23 May 2006 23:07:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm3
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20060522022709.633a7a7f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060522022709.633a7a7f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
>
[snip]
>  git-alsa.patch

I have noticed small problem with ALSA.
When I boot 2.6.17-rc4-mm3 everything is ok, then I switch to
2.6.17-rc4-git11 - everything is ok. But when I switch back to
2.6.17-rc4-mm3 PCM is mute (off), Spread Front to Surround and
Center/LFE is off, Channel Mode is set to 2ch (should be 6ch).

/sbin/alsactl -v
alsactl version 1.0.11rc2

This is an user space tools bug?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
