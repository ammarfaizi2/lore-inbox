Return-Path: <linux-kernel-owner+w=401wt.eu-S1750738AbWLKXd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWLKXd3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWLKXd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:33:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:54860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbWLKXd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:33:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Et9J+GKVXb/znQbBwqNMScGV13TwhS8aVYM6Z9/fPms3ohp2W/FLNXqZfdZuyTVhb46pXQZVLfM/nKSEvdgrZNaxy0HLqOXxp3yzXakWJPUdMghSTNrlLru270xc7qmIv7TNAuWQ56JQt/uRAcMD+YNw8SyADSx0UMdPa4YVkxQ=
Message-ID: <e9c3a7c20612111533o75683c2j30dbf440696932a6@mail.gmail.com>
Date: Mon, 11 Dec 2006 16:33:26 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Voipio Riku" <Riku.Voipio@movial.fi>
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates: more chips, alarm, 12hr mode, etc
Cc: "David Brownell" <david-b@pacbell.net>, rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>, i2c@lm-sensors.org
In-Reply-To: <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612081859.42995.david-b@pacbell.net>
	 <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>
	 <200612111155.09435.david-b@pacbell.net>
	 <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
X-Google-Sender-Auth: 3311f48766c66753
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/06, Voipio Riku <Riku.Voipio@movial.fi> wrote:
<snip>
> > Have you asked around for anyone who may have insights about i2c-iop3xx
> > driver bugs?  Maybe the driver maintainers, or arm-linux folk, or on
> > the i2c list.
>
> I was told to contact Dan Williams, I didn't get any response.
>
Hi Riku, this is the first message I have received.

According to the latest specification update
(http://www.intel.com/design/iio/specupdt/27351910.pdf) there are no
known issues with the i2c.  I looked through the thread and did not
see what board you are using, can you send those details?

I have not dealt with the i2c-iop3xx driver in the past. Have you
tried contacting the last person to make functional changes to the
driver?
http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=39288e1ac10b3b9a68a629be67d81a0b53512c4e

Regards,
Dan
