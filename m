Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRCWJbu>; Fri, 23 Mar 2001 04:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbRCWJbk>; Fri, 23 Mar 2001 04:31:40 -0500
Received: from t2.redhat.com ([199.183.24.243]:13815 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S130433AbRCWJb3>; Fri, 23 Mar 2001 04:31:29 -0500
Date: Fri, 23 Mar 2001 09:29:57 +0000
From: Tim Waugh <twaugh@redhat.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010323092957.F1469@redhat.com>
In-Reply-To: <20010323011140.A1176@werewolf.able.es> <E14gFRT-0003f4-00@the-village.bc.nu> <20010323013800.A1918@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010323013800.A1918@werewolf.able.es>; from jamagallon@able.es on Fri, Mar 23, 2001 at 01:38:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 01:38:00AM +0100, J . A . Magallon wrote:

> Yes, a null sentence can shut up the compiler. But what is the purpose of
> a jump to the end instead of a return ? Some optimization ?

So that when someone decides that the function needs to do some extra
initialisation at the beginning and some extra cleanup at the end,
they don't accidentally miss an exit point.

Tim.
*/
