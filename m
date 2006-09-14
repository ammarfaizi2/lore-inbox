Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWINBI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWINBI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWINBI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:08:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2268
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751297AbWINBI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:08:57 -0400
Date: Wed, 13 Sep 2006 18:09:48 -0700 (PDT)
Message-Id: <20060913.180948.74739586.davem@davemloft.net>
To: jlayton@poochiereds.net
Cc: dlstevens@us.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to
 sockets that are joined to group
From: David Miller <davem@davemloft.net>
In-Reply-To: <1158163943.15449.75.camel@dantu.rdu.redhat.com>
References: <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
	<1158163943.15449.75.camel@dantu.rdu.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@poochiereds.net>
Date: Wed, 13 Sep 2006 12:12:23 -0400

> Most of the RFC's I've looked at don't seem to have much to say about
> how multicasting works at the socket level. Is there an RFC or
> specification that spells this out, or is this one of those situations
> where things are somewhat open to interpretation?

In these cases, whatever BSD does is effectively the definition of
what should happen since it is the "BSD socket API".
