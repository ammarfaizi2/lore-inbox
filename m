Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWDLXKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWDLXKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDLXKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:10:43 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:6385 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932367AbWDLXKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:10:42 -0400
In-Reply-To: <20060412214108.GA12480@suse.de>
References: <443D3DED.5030009@keyaccess.nl> <20060412214108.GA12480@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7724966D-F760-4075-8D69-B4B73700A9BA@kernel.crashing.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Is platform_device_register_simple() deprecated?
Date: Wed, 12 Apr 2006 18:09:48 -0500
To: Greg KH <gregkh@suse.de>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 12, 2006, at 4:41 PM, Greg KH wrote:

> On Wed, Apr 12, 2006 at 07:50:37PM +0200, Rene Herman wrote:
>> Hi Greg, Russel, Dmitry.
>>
>> ALSA is using platform_device_register_simple(). Jean Delvare  
>> pointed:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
>>
>> out, where _simple looks to be slated for removal. Is this indeed the
>> case? ALSA isn't using the resources -- doing a manual alloc/add  
>> would
>> not be a problem...
>
> Great, care to convert ALSA to use the proper api so we can remove
> platform_device_register_simple()?

Can we mark this deprecated and add it to feature-removal-schedule.txt.

I'm using it about half a dozen times in arch/powerpc and wasn't sure  
if it was planned on being removed.

- kumar
