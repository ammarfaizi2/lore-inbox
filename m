Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVAWWAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVAWWAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAWWAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:00:30 -0500
Received: from main.gmane.org ([80.91.229.2]:55241 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261363AbVAWWA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:00:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: Re: System beeper - no sound from mobo's own speaker
Date: Sun, 23 Jan 2005 23:58:04 +0200
Message-ID: <ct16l6$jra$1@sea.gmane.org>
References: <200501231937.53099.stephen@g6dzj.demon.co.uk> <20050123225010.0172a6e0.vsu@altlinux.ru> <200501232007.21027.stephen@g6dzj.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-tregw3mdf.dial.inet.fi
User-Agent: Mozilla Thunderbird 1.0 (X11/20041216)
X-Accept-Language: en-us, en
In-Reply-To: <200501232007.21027.stephen@g6dzj.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Kitchener wrote:
> On Sunday 23 Jan 2005 19:50, Sergey Vlasov wrote:
>>Does "modprobe pcspkr" help?  In 2.6.x kernels the PC speaker support
>>can be built as a loadable module; probably the startup scripts do not
>>load it automatically.
> 
> You know - I've just found that and yes it does help on one system, so I'm 50% 
> better off - just need to find out where to put the command so that it loads 
> it on startup...modules.conf would be it I guess.

Put it on /etc/modprobe.preload

-- 
Anssi Hannula

