Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271053AbVBEUOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271053AbVBEUOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbVBEUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:14:10 -0500
Received: from mail.tmr.com ([216.238.38.203]:46340 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S273561AbVBEUM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:12:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
Date: Sat, 05 Feb 2005 15:28:13 -0500
Organization: TMR Associates, Inc
Message-ID: <42052C5D.3010203@tmr.com>
References: <20050204213337.GA12347@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1107633728 27495 192.168.12.10 (5 Feb 2005 20:02:08 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org
To: John M Flinchbaugh <john@hjsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
In-Reply-To: <20050204213337.GA12347@butterfly.hjsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh wrote:
> i'm using a thinkpad r40 w/ intel8x0 sound card.  it worked with 2.6.10.
> 
> % ogg123 -d alsa09 file.ogg
> 
> i can get no sound through either alsa or oss emulation.
> 
> it appears to be playing but nothing can be heard.  i've poked around at
> the mixers for mutes, master, and pcm volume.

I have the same problem and have been posting to other lists and groups 
without results. Under FC2 my ASUS 1681 had both sound and wireless. 
With recent kernels, nothing, both FC3 and kernel.org.

If you have system-config-soundcard (ie. FCx) try to configure. I get a 
response saying the rate locks at 48000 instead 44100 as requested.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
