Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVFHHGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVFHHGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVFHHGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:06:46 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:8797 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262125AbVFHHGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:06:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XsptamsV82Z3SNk4+iMHBQk+bnGKfUDEKeH1bO9Rkx1XK/LrIBxiebEu6vJJmGk0+jPwpjjAAwWdWBeI1+i5cSLYXpyrSsVYJHYuG/vrVAYVDS8PowiM6+fGwWRDQtk+ZRor1ddD3nx7r5h7yQozU9p1Bym1Ro+ymRqSP9zzsfY=
From: =?iso-8859-1?q?S=F8ren_Lott?= <soren3@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Wed, 8 Jun 2005 04:08:04 -0300
User-Agent: letmego
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200506072259.52848.soren3@gmail.com> <20050608075340.12bd49e9.khali@linux-fr.org>
In-Reply-To: <20050608075340.12bd49e9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506080408.04914.soren3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 02:53, Jean Delvare wrote:
> Hi Soren,
Hi,
> Which kernel are you upgrading from?

from 2.6.12-rc5-mm2

> Is CONFIG_PNPACPI set? If it is, try whithout it.

nope, don't even have CONFIG_PNP set.

> If it doesn't work, please try reverting (in reverse order):
>   gregkh-i2c-hwmon-01.patch
>   gregkh-i2c-hwmon-02.patch
>   gregkh-i2c-hwmon-03.patch
>   i2c-chips-need-hwmon.patch
>   gregkh-i2c-hwmon-02-sparc64-fix.patch
> and see how it goes.

yeap, reverting these did the trick, all i2c entries in sysfs are back. :)

> Thanks,

thanks alot.
cheers.

-SL
