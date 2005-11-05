Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVKESxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKESxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKESxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:53:03 -0500
Received: from ns2.suse.de ([195.135.220.15]:34535 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932198AbVKESxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:53:01 -0500
Date: Sat, 5 Nov 2005 19:52:55 +0100
From: Olaf Hering <olh@suse.de>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: zippel@linux-m68k.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 66/82] remove linux/version.h from fs/hfs/
Message-ID: <20051105185255.GA20293@suse.de>
References: <20050710193614.66.sNRbVO4020.2247.olh@nectarine.suse.de> <436CEDCE.6010704@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436CEDCE.6010704@tremplin-utc.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Nov 05, Eric Piel wrote:

> 10.07.2005 21:36, Olaf Hering wrote/a écrit:
> >changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
> Hello,
> 
> I've just changed LOCALVERSION on 2.6.14 and noticed that the patches 
> for hfs and hfsplus had still not made their way. As I couldn't find any 
> tree which contains them, I was wondering if they wouldn't have been 
> "lost in space" ?

I noticed that as well today. There are many more places where version.h
is still included...

find * -name "*.[ch]" | xargs grep -El '<linux/version.h>' | wc -l
213

I did send it for stuff like net/ieee80211/ieee80211_crypt_tkip.c 

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
