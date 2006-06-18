Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWFRGKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFRGKD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFRGKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:10:03 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:63674 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751098AbWFRGKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:10:01 -0400
Subject: Re: [PATCH-2.4] allow core files bigger than 2GB
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Cc: marcelo@kvack.org, jolivares@gigablast.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060617214507.GA1213@1wt.eu>
References: <20060617214507.GA1213@1wt.eu>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 08:09:53 +0200
Message-Id: <1150610993.3117.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 23:45 +0200, Willy Tarreau wrote:
> Marcelo,
> 
> I think I have not sent you this one. It looks valid to me.
> I can queue it in -upstream if you prefer to pull everything
> at once.


Hi,

This is a rather complex issue, to the point that your patch is not
sufficient actually. While it will create a core file, it's not really a
good one, and there are some nasty other issues with it (esp on 64 bit
systems). The enterprise distro kernels have a more complete patch for
this (I'm pretty sure both RH and SUSE have fundamentally the same patch
for this), if you really want this functionality I suggest getting the
patch from either of those distros to get the full thing (there's some
security angle to this even iirc).

Greetings, 
   Arjan van de Ven

