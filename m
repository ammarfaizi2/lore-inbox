Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWF3A7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWF3A7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWF3A7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:59:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:59674 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964848AbWF3A7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:59:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWDqkQIinis972f22hTW7dK/QTlBfRdZeVV/Odb71laZ4bgBpuq75x5OxRiIabFZ6pq4L/H9suiZNIjdiz0iwZp4j3kHVdrAxHiu4pX4QJqzJJgDlYsVCzXWUVyUNmpSSc9w771yAlU0rmr5WO8Gyk2MWUFvY5z2t8+ED/BXIzs=
Message-ID: <9e4733910606291759t140e1ea7yf14cca699988cd50@mail.gmail.com>
Date: Thu, 29 Jun 2006 20:59:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_V4L1 shouldn't be user-visible
Cc: "Adrian Bunk" <bunk@stusta.de>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151617411.3728.66.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629192124.GD19712@stusta.de> <1151612317.3728.34.camel@praia>
	 <20060629210829.GG19712@stusta.de> <1151617411.3728.66.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Also, on V4L side, the V4L1 api is stopping V4L development. V4L API 2
> is already at kernel since the beginning of kernel 2.6 series, and fixes
> several flaws at the old api (V4L1 API were designed on 2.1 series).
> Still now, most applications still implement only V4L1, and people do
> submit newer v4l1 drivers to us.
>
> We do really go ahead, making V4L2 API the standard.

I don't think anyone would complain about dropping V4L1 if the people
pushing V4L2 were to port the 25 or so drivers that depend on V4L1 to
the V4L2 API.  As long as those V4L1 dependent drivers are around
people are going to want to keep using V4L1. You may want to consider
building some in-kernel compatibility APIs into V4L2 to make porting
those drivers easier.

-- 
Jon Smirl
jonsmirl@gmail.com
