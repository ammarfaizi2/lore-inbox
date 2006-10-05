Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWJEAGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWJEAGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWJEAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:06:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41390 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751244AbWJEAGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:06:45 -0400
Date: Wed, 4 Oct 2006 19:06:41 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4]: Spidernet stop queue when queue is full
Message-ID: <20061005000641.GM4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com> <20061003205729.GF4381@austin.ibm.com> <200610040019.43028.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610040019.43028.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 12:19:42AM +0200, Arnd Bergmann wrote:
> On Tuesday 03 October 2006 22:57, Linas Vepstas wrote:
> >                 result = NETDEV_TX_LOCKED;
> 
> Hmm, this looks a little strange to me. 

Right. This was left-over cruft from back when.

I'll fix this and resend the whole series tommorrow or friday, 
I've got a few more minor performnace tweaks, an implementation
of NETIF_F_SG, and another fix or two, etc.

--linas

