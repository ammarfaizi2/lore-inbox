Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVCHU3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVCHU3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVCHU2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:28:35 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:3036 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262262AbVCHUKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:10:19 -0500
Message-ID: <422E06AD.9030500@tomt.net>
Date: Tue, 08 Mar 2005 21:10:21 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George Georgalis <georgalis@gmail.com>
Cc: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
       misc@list.smarden.org, supervision@list.skarnet.org, nix@esperi.org.uk,
       mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
References: <20050303214023.GD1251@ixeon.local>	 <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>	 <20050303224616.GA1428@ixeon.local>	 <871xaqb6o0.fsf@amaterasu.srvr.nix>	 <20050308165814.GA1936@ixeon.local>	 <20050308171953.GB1936@ixeon.local> <d91f4d0c050308112120aace61@mail.gmail.com>
In-Reply-To: <d91f4d0c050308112120aace61@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Georgalis wrote:
> Here is a problem with 2.6.10:
> 
> while read file; do mplayer $file ; done <mediafiles.txt
> 
> or
> 
> tail -n93  mediafiles.txt | while read file; do mplayer $file ; done
> 
> for each file path in that text file I get:
> 
> Failed to open /dev/rtc: Permission denied (it should be readable by the user.)

^- This is also emitted by mplayer. It usually does this on any standard 
system.

> In addition the audio pcm level is set to zero (presumably by mplayer).
> 
> This does work:
> for file in `cat mediafiles.txt`; do mplayer $file ; done
> 
> but discovering and fixing code now broke will be unpleasent.
> What exactly is going on? 
> 
> // George
> 

