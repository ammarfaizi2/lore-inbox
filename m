Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSBRS3Q>; Mon, 18 Feb 2002 13:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290646AbSBRSYB>; Mon, 18 Feb 2002 13:24:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:24582 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290157AbSBRSTJ>;
	Mon, 18 Feb 2002 13:19:09 -0500
Date: Mon, 18 Feb 2002 10:14:17 -0800
From: Greg KH <greg@kroah.com>
To: Patrik Weiskircher <me@justp.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd zombie
Message-ID: <20020218181417.GA19992@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014039193.523.42.camel@dev1lap>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 21 Jan 2002 15:37:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 02:33:13PM +0100, Patrik Weiskircher wrote:
> killall khubd results to:
> 10 ?        Z      0:00 [khubd <defunct>]
> 
> is this ok?
> if not, how can i solve this?

What kernel version is this?
And why are you trying to kill khubd from userspace?  Unloading the
usbcore module will do the same thing.

thanks,

greg k-h
