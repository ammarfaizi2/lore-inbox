Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFDLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFDLfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFDLfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 07:35:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:10936 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261324AbVFDLfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 07:35:31 -0400
Date: Sat, 4 Jun 2005 13:33:16 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12?
Message-ID: <20050604113316.GA3883@electric-eye.fr.zoreil.com>
References: <42A0D88E.7070406@pobox.com> <20050603233756.GA27081@electric-eye.fr.zoreil.com> <42A167FE.2020008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A167FE.2020008@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> >Any chance the r8169 queue could be merged in mainline before ?
> 
> I'll push the length check.

Cool.

> Everything else is a new feature.

Hmmmm... Ok, let's have some r8169 handwaving/advocacy/explanation to
tell what is going on.

- From a usability viewpoint, the PCI ID for the USRobotics adapter
  should be included. It has been reported around 10/04/2005.
  Consider the usual july/LKS/conf period and it will not be available
  in a stable serie before september (it is not a bugfix, it will not
  be in 2.6.12.x either). USR has cut the price: it will have some
  effect.

- The new features are not really new:
  o 03/2005 for Stephen Hemminger's stats + other changes
    -> it does not collide with existing functions. 
  o 03/2005 for the message level support
    -> not new but it will be noticed, yes.

- Some of the usual suspects on netdev know the code and even if your
  favorite r8169 maintainer has a real day job like everyone, I usually
  manage to dig the issues when something hits the fan (no engagement in
  sight, it helps :o) ).

Of course, you are free to ignore these points if you already took them
into consideration.

--
Ueimor
