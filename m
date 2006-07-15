Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWGOX5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWGOX5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWGOX5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:57:55 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:12963 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964812AbWGOX5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:57:55 -0400
Message-ID: <44B9814B.4050103@sbcglobal.net>
Date: Sat, 15 Jul 2006 18:59:07 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: [stable] Linux 2.6.17.5
References: <20060715030047.GC11167@kroah.com> <20060715032834.GA5944@kroah.com> <20060715042045.GB4322@kroah.com>
In-Reply-To: <20060715042045.GB4322@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jul 14, 2006 at 08:28:34PM -0700, Greg KH wrote:
>> On Fri, Jul 14, 2006 at 08:00:47PM -0700, Greg KH wrote:
>>> We (the -stable team) are announcing the release of the 2.6.17.5 kernel.
>> Oops, please note that we now have some reports that this patch breaks
>> some versions of HAL.  So if you're relying on HAL, you might not want
>> to use this fix just yet (please evaluate the risks of doing this on
>> your own.)
> 
> Hm, HAL 0.5.7 seems to work fine for me.  Anyone else seeing any
> problems with this version?  Older versions?
> 

I'm running 0.5.7 and also see no problems.

FTR, I'm invoking

/usr/sbin/hald --daemon=yes --verbose=yes --use-syslog

and /var/log/messages looks no different than usual (last under 2.6.17.3).

> thanks,
> 
> greg k-h

NP

Matt

