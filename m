Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWE1XJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWE1XJL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 19:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWE1XJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 19:09:11 -0400
Received: from mail1.cluenet.de ([195.20.121.7]:35006 "EHLO mail1.cluenet.de")
	by vger.kernel.org with ESMTP id S1751035AbWE1XJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 19:09:10 -0400
Date: Mon, 29 May 2006 01:09:09 +0200
From: Daniel Roesen <dr@cluenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":": i82875p UE
Message-ID: <20060528230909.GA14256@srv01.cluenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <89E85E0168AD994693B574C80EDB9C2703F7749D@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703F7749D@uk-email.terastack.bluearc.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 09:55:47AM +0100, Andy Chittenden wrote:
> Every one of our ASUS P4C800-E and ASUS P4C800 based machines that I've
> installed a 2.6.16 smp based kernel on is logging messages of the form:
> 
> EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":":
> i82875p UE
> 
> every second or so. So I've downgraded them back to 2.6.15. I believe
> the message is moaning that the ECC memory has unrecoverable errors.
> However, the memory in the machines I've tried passes memtest. And
> I'd've expected system hangs which we don't get.

I'm experiencing the same problem, which sorta keeps me somewhat from
using an up-to-date kernel.

Also reported to Fedora:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=191506

rmmod'ing the EDAC driver makes those messages go away, but that's
sticking the head into the sand. 

Are actually errors happening when those messages pop up? The system
is running rock-solid since ages. It's only with the new kernels and
it's EDAC module where those errors do pop up...


Best regards,
Daniel

-- 
CLUE-RIPE -- Jabber: dr@cluenet.de -- dr@IRCnet -- PGP: 0xA85C8AA0
