Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVDZAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVDZAEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDZAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:04:42 -0400
Received: from [62.206.217.67] ([62.206.217.67]:18844 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261195AbVDZAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:04:37 -0400
Message-ID: <426D8587.6060507@trash.net>
Date: Tue, 26 Apr 2005 02:04:23 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
References: <200504240008.35435.kernel-stuff@comcast.net>	 <1114332119.916.1.camel@localhost.localdomain>	 <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net>	 <20050425153541.GC16828@wotan.suse.de> <1114452899.2012.2.camel@localhost.localdomain>
In-Reply-To: <1114452899.2012.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
> Usually gives in after about 20 minutes of gcc compiling, sometimes even
> up to 40 minutes. I had 2.6.12-rc2 stand for 2-3 hours so it seems ok.
> If anyone has a better recipe for it please do tell.

uml seems to trigger the bug faster, I'm usually seeing it within
a couple of minutes. I'm doing a binary search now.

> It doesn't appear to be any of the obvious patch candidates...

Which ones did you try?
