Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVJHLfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVJHLfH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 07:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVJHLfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 07:35:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52650 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751032AbVJHLfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 07:35:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Modular i810fb broken, partial fix
Date: Sat, 8 Oct 2005 13:31:12 +0200
Message-ID: <1308gutgj0dx4$.1ie66adezdlua$.dlg@40tude.net>
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-51-179.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2005 18:39:35 +0800, Antonino A. Daplas wrote:

> Bernhard Rosenkraenzer wrote:
>> Hi,
>> i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
>> It compiles, but the module doesn't actually load because the kernel doesn't 
>> recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).
> 
>> 
>> The attached patch fixes this.
>> 
>> However, the resulting module still doesn't work.
>> It loads, and then garbles the display (black screen with a couple of yellow 
>> lines, no matter what is written into the framebuffer device).
> 
> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
> Does i810fb work if compiled statically?

Since this is *really* coming out often: is there a specific reason
why the fb modules do not depend on fbcon?

-- 
Giuseppe "Oblomov" Bilotta

"They that can give up essential liberty to obtain
a little temporary safety deserve neither liberty
nor safety." Benjamin Franklin

