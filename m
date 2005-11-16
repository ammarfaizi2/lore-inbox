Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVKPPbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVKPPbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVKPPbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:31:09 -0500
Received: from mail1.kontent.de ([81.88.34.36]:26836 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751476AbVKPPbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:31:08 -0500
From: Oliver Neukum <oliver@neukum.org>
To: jmerkey <jmerkey@utah-nac.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Wed, 16 Nov 2005 16:30:59 +0100
User-Agent: KMail/1.8
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <20051116135116.GA24753@wohnheim.fh-wedel.de> <437B453E.8070905@utah-nac.org>
In-Reply-To: <437B453E.8070905@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161630.59588.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. November 2005 15:42 schrieb jmerkey:
> Map a blank ro page beneath the address range when stack memory is 
> mapped is trap on page faults to the page when folks go off the end of 
> th e stack.
> 
> Easy to find.

Provided you can easily trigger it. I don't see how that is a given.

	Regards
		Oliver
