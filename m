Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTGQXIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271617AbTGQXIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:08:00 -0400
Received: from bgp01116707bgs.westln01.mi.comcast.net ([68.42.104.61]:12056
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S271606AbTGQXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:07:58 -0400
Message-ID: <3F172693.2060701@blackmagik.dynup.net>
Date: Thu, 17 Jul 2003 18:43:31 -0400
From: Eric Blade <eblade@blackmagik.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: radeonfb patch for 2.4.22...
References: <Pine.LNX.4.44.0307171827260.10255-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307171827260.10255-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:

>>This has been happening to me on my Radeon and on my Voodoo 3 for as 
>>long as there has been framebuffers and they have in fact compiled and 
>>worked.  I thought this was normal?
>>    
>>
>
>Its caused from switching from text mode to graphics mode. Take for 
>example I have grabbed th epci regions for my voodoo card and then wrote 
>to them. This was done before I switched to graphics mode. It messed up my 
>vga text screen. So when we go from text to graphics we have stale data. 
>
>
>
>
>  
>
So, basically, it's normal, as I thought. 

Perhaps a quick clear screen as it's initialized would be good...


-- 
----BEGIN GEEK CODE BLOCK----
Version: 3.1
GB/CS/MC/MU/O @d+ s:- a- C++++ UL++++  !P  L+++ !E W+++ !N !o K? w--- @O++ !M !V PS+ PE- Y PGP- @t 5? X R tv-- b- DI++ D++ G e* h* r  y+ 
----END GEEK CODE BLOCK----




