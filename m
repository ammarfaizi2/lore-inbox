Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTEMPRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTEMPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:17:18 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:53183 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261375AbTEMPRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:17:16 -0400
Date: Tue, 13 May 2003 16:30:01 +0100
From: Ian Molton <spyro@f2s.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARM26 [NEW ARCHITECTURE]
Message-Id: <20030513163001.3a80f822.spyro@f2s.com>
In-Reply-To: <1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>
References: <20030513153315.73679a38.spyro@f2s.com>
	<1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2003 15:23:39 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> 
> I guess its no crazier than the MacII port. What does Russell think
> about it however and also is this 2.4 or 2.5 targetted ?

I know its a bit insane, but there appears (at long last!) to be a small
community picking up ;-)

Russell is fine with it, and in fact, you can see he has begun accepting
patches from me to remove arm26 from 2.5.

it is 2.5 targetted currently 2.5.30, but the arch/ and asm/ stuff is
independant as far as the rest of the tree is concerned, so it may as
well go in as 'current' and then I can submit smaller patches to 'catch
up' with the rest.

it actually compiles on 2.5.30 (at least, some of it does ;-) and runs,
excpet so far, mm stuff fails and user-land falls over HARD ver early.

where do I send my patches? ;-)

-- 
Spyros lair: http://www.mnementh.co.uk/
Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.

Systems programmers keep it up longer.
