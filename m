Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWEDV3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWEDV3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWEDV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:29:36 -0400
Received: from main.gmane.org ([80.91.229.2]:61921 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751405AbWEDV3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:29:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
Date: Thu, 4 May 2006 23:28:04 +0200
Message-ID: <1vsfcg3epbb29.t96cunohji42$.dlg@40tude.net>
References: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com> <gs7iuaocrzmp.s33e3qhm21bl.dlg@40tude.net> <445A68AC.3090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-17-56.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2006 04:48:44 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> On Tue, 2 May 2006 21:51:13 +0200, Olivier Fourdan wrote:
>> 
>>> I'm surprised noone has raised that issue yet, so I'm wondering if I'm
>>> missing something obvious :) When using the fb in 2.6.16.x and
>>> 2.6.17-rc3, the screen stays just black, nothing is displayed... I'm
>>> using the regular unaccelerated vesa framebuffer.
>> 
>> It may sound silly and it's probably not relevant to your case, but I
>> had this kind of result during a kernel upgrade some versions ago when
>> I forgot the fbcon module.
> 
> Not silly because that is exactly what happened. He sent me his config in a
> private mail.

Oh.

> I don't know what method he used to upgrade his kernel, but the setting
> changed from 'y' to 'm', and I've received quite a few reports from
> different users on this lately...

Well, when it happened to me it was because I switched from a distro
kernel to a custom build and so the error was entirely on my part. I
still think that some kind of warning in the dmesg or appropriate
wording in the help for the framebuffer devices or for fbcon would
help sort this FAQ out.

OTOH, if the OP made oldconfig it would be interesting to see what
caused the change in configuration ...


-- 
Giuseppe "Oblomov" Bilotta

"E la storia dell'umanità, babbo?"
"Ma niente: prima si fanno delle cazzate,
 poi si studia che cazzate si sono fatte"
(Altan)
("And what about the history of the human race, dad?"
 "Oh, nothing special: first they make some foolish things,
  then you study what foolish things have been made")

