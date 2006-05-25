Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWEYVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWEYVcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWEYVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:32:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:3599 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030430AbWEYVcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:32:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pX7NmcJllck6g8AzimnE9b0sJ1GnaIhSGccQyIvSWVjyUA0PxOPEVvp/z39GtF/YMZVc0nERut/dffnyTVdzOoEmwcCYeGbNaD62oH8Hpm4/wfiCgINkIAK70sbmtuaO8giVZF53PyrnMKXXrTjAnwxLIQVHgsoEX003/C/L71M=
Message-ID: <6bffcb0e0605251432s55969e82la206d8ad863ba502@mail.gmail.com>
Date: Thu, 25 May 2006 23:32:49 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: devmazumdar <dev@opensound.com>
Subject: Re: How to check if kernel sources are installed on a system?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e55715+usls@eGroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e55715+usls@eGroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/06, devmazumdar <dev@opensound.com> wrote:
> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.

How about something like this

if [ -f /lib/modules/`uname -r`/build/Makefile ]
 then
  ...
fi

[snip]

> provide a stable kernel API, then atleast please make this a requirement.
>
>
> best regards
>
> Dev Mazumdar
> 4Front Technologies
> http://www.opensound.com

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
