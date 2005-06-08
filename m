Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVFHUmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVFHUmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFHUmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:42:01 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:35972 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261605AbVFHUl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:41:56 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] capabilities not inherited
From: Alexander Nyberg <alexn@telia.com>
To: Manfred Georg <mgeorg@arl.wustl.edu>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 22:41:54 +0200
Message-Id: <1118263314.969.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-06-08 klockan 15:27 -0500 skrev Manfred Georg:
> Hi,
> 
> I was working with passing capabilities through an exec and it
> didn't do what I expected it to.  That is, if I set a bit in
> the inherited capabilities, it is not "inherited" after an
> exec().  After going through the code many times, and still not
> understanding it, I hacked together this patch.  It probably
> has unforseen side effects and there was probably some
> reason it was not done in the first place.

Please read the thread at
http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/1571.html

Basically it says that because a broken interface was accepted from the
beginning it can't be changed due to the security aspect.

The whole thing sucks, sorry.

