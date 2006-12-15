Return-Path: <linux-kernel-owner+w=401wt.eu-S932635AbWLOArh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWLOArh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWLOArh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:47:37 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:49576 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932674AbWLOAr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:47:29 -0500
Message-ID: <4581F093.3020806@lwfinger.net>
Date: Thu, 14 Dec 2006 18:47:15 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Uli Kunitz <kune@deine-taler.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
References: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>	 <341A1CE8-DF10-4CD5-B675-89449256EAB5@deine-taler.de> <5b8e20700612141348l66af58b6lb6899b710d1d9c14@mail.gmail.com>
In-Reply-To: <5b8e20700612141348l66af58b6lb6899b710d1d9c14@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bommarito wrote:
> Hello Uli,
>  Yes, apologies, I had been waiting for an abandoned bugzilla entry
> to get attention, and when I realized it was assigned to a dead-end, I
> had simply posted the patch without checking for prior messages.
>  I was further confused by the fact that it hadn't made its way into
> any of the 19-gitX sets (and for that matter, the window for
> 2.6.20-rc1 has come and gone and this still remains unfixed), despite
> how clear the error was and how trivial the fix seems.

I was not aware that a bugzilla entry existed for this problem. I learned about it when my system 
would hang on bootup if the bcm43xx card was installed. By bisection, I learned which commit was 
causing the problem. About that time, the complete fix was discussed on the netdev and bcm43xx 
mailing lists. I was a little perturbed that only part of the fix was accepted into 2.6.19-gitX.

The full fix was pushed to John Linville on Dec. 10, who pushed it on to Jeff Garzik on Dec. 11. I 
have not yet seen any message sending it on to Andrew Morton or Linus.

A bug fix will always be accepted, particularly one that only changes 2 lines - it is only a new 
feature that will no longer be accepted once the -rc1 stage is reached. If this message doesn't do 
the trick and it isn't included by -rc2, I'll ping Jeff to see what happened. Changes always take 
longer than one likes, but one needs to be careful.

Larry

