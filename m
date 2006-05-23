Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWEWIj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWEWIj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWEWIj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:39:27 -0400
Received: from bsamwel.xs4all.nl ([82.92.179.183]:39720 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S932129AbWEWIj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:39:26 -0400
Message-ID: <4472C9D0.9010508@samwel.tk>
Date: Tue, 23 May 2006 10:37:36 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 10/14/] Doc. sources: expose laptop-mode
References: <20060521203349.40b40930.rdunlap@xenotime.net>	<20060521205750.003b737c.rdunlap@xenotime.net>	<44714AC1.1060004@samwel.tk> <20060522083531.ad725cdf.rdunlap@xenotime.net>
In-Reply-To: <20060522083531.ad725cdf.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 22 May 2006 07:23:13 +0200 Bart Samwel wrote:
>> Point for discussion: should the laptop_mode script really still be in 
>> laptop-mode.txt? AFAIK most distros use laptop-mode-tools or use their 
>> own scripts to control this. Furthermore, the existing script is mostly 
>> unmaintained, and it is full of bugs that were fixed long ago in 
>> laptop-mode-tools (which was originally a fork of the script). I think 
>> it would be better to replace it with a bit of documentation on which 
>> things a laptop mode control script *should* tweak, *may want to* tweak, 
>> etc., accompanied by an explanation why these tweaks are needed. I.e, an 
>> "annotated spec", as one would expect to find in documentation. I'll 
>> submit a patch to this effect when I find some time.
> 
> If it's really so unmaintained and mostly replaced, sounds like it should
> be removed.  OTOH, if you want to keep several source files and/or
> scripts, I would prefer to see a laptop-mode subdirectory for them.

I'm all for completely removing the script, so no subdirectories needed 
as far as I'm concerned. I'll submit a patch to replace the script by 
some text explaining what such a script should do.

Cheers,
Bart
