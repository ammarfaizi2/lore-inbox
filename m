Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVJHOzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVJHOzj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 10:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVJHOzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 10:55:39 -0400
Received: from main.gmane.org ([80.91.229.2]:21913 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932112AbVJHOzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 10:55:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Modular i810fb broken, partial fix
Date: Sat, 8 Oct 2005 16:51:28 +0200
Message-ID: <1pfuqilz0eim.1n6ig5c3s2r3.dlg@40tude.net>
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net> <1308gutgj0dx4$.1ie66adezdlua$.dlg@40tude.net> <4347C393.5090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-51-179.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2005 21:03:15 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> On Sat, 08 Oct 2005 18:39:35 +0800, Antonino A. Daplas wrote:
>> 
>>> Bernhard Rosenkraenzer wrote:
>>>> Hi,
>>>> i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
>>>> It compiles, but the module doesn't actually load because the kernel doesn't 
>>>> recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).
>>>> The attached patch fixes this.
>>>>
>>>> However, the resulting module still doesn't work.
>>>> It loads, and then garbles the display (black screen with a couple of yellow 
>>>> lines, no matter what is written into the framebuffer device).
>>> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
>>> Does i810fb work if compiled statically?
>> 
>> Since this is *really* coming out often: is there a specific reason
>> why the fb modules do not depend on fbcon?
>> 
> 
> Some need fbdev only, without fbcon, ie, embedded.

And does fbcon make sense *without* fbdevs?

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

