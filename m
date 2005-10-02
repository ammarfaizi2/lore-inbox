Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJBPOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJBPOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 11:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJBPOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 11:14:24 -0400
Received: from main.gmane.org ([80.91.229.2]:62880 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751108AbVJBPOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 11:14:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Sun, 2 Oct 2005 17:13:29 +0200
Message-ID: <1l32ctqb3wuk8$.xbs0uj9dx0k$.dlg@40tude.net>
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com> <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net> <433C52F0.6000401@gmail.com> <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net> <433E2387.2090608@gmail.com> <15vft1mw0n773.w7bplfheyl29.dlg@40tude.net> <433E69A4.5050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-49-122.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Oct 2005 18:49:08 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> On Sat, 01 Oct 2005 13:49:59 +0800, Antonino A. Daplas wrote:
>> 
>>> Looks like the nv driver just ignored the EDID and used one of
>>> its built-in VESA modes.  If you notice, X's EDID ouput is the same
>>> as nvidiafb's. But the resulting timings are different.
>>>
>>> In contrast, nvidiafb will attempt to use the EDID, and only as a last
>>> resort, use one of the timings in the global mode database.
>> 
>> I see. And when EDID is enabled for the module, it won't let me touch
>> those timings at all.
> 
> Yes. But if the EDID block specified a usable hsync and vsync range, the
> timings can be customized.  In your case it does not.

/me is wondering if it would be possible to hack the EDID block and
fix it ... and whether it's worth the risk.

>> Maybe a "noddc" or "noedid" module option for 
>> when EDID support is compiled in and one wants to work without it?
> 
> It is a good idea.  Especially since I've already encountered a lot of
> crappy EDID blocks.

That'd be nice :)

Thank you very much for all your help and information. I can now
exploit my eye-destroying 133dpi in console too :)

-- 
Giuseppe "Oblomov" Bilotta

"They that can give up essential liberty to obtain
a little temporary safety deserve neither liberty
nor safety." Benjamin Franklin

