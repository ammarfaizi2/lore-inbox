Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVDZJg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVDZJg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVDZJg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:36:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7839 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261435AbVDZJgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:36:55 -0400
Date: Tue, 26 Apr 2005 11:36:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050426093636.GB4175@elf.ucw.cz>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp> <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu> <426D9AC0.5020908@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <426D9AC0.5020908@lab.ntt.co.jp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 26-04-05 10:34:56, Takashi Ikebe wrote:
> I think that's the common sense in every carrier.
> If we reboot the switch, the service will be disrupted.
> The phone network is lifeline, and does not allow to be disrupt by just 
> bug fix.
> I think same kind of function is needed in many real 
> enterprise/mission-critical/business area.
> 
> All do with ptrace may affect target process's time critical task. (need 
> to stop target process whenever fix)
> All implement in user application costs too much, need to implement all 
> the application...(and I do not know this approach really works on time 
> critical applications yet.)
> There are clear demand to realize this common and GPL-ed function....
        ~~~~~~~~~~~~~~~~
I had very strong urge to reply with "<plonk>" here.

Clearly noone but you wants to make kernel more ugly just for "faster
ptrace". If you want faster ptrace, fine, advertise it as such and
provide nice and small patch to make it faster.

If you are going to handwave about "clear demand", well, find some
other list to troll on.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
