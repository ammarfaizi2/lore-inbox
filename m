Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFAGqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFAGqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWFAGqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:46:11 -0400
Received: from gw.openss7.com ([142.179.199.224]:38035 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750709AbWFAGqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:46:10 -0400
Date: Thu, 1 Jun 2006 00:46:08 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601004608.C21730@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601063012.GC28087@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Jun 01, 2006 at 10:30:13AM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 01 Jun 2006, Evgeniy Polyakov wrote:
> 
> Since pseudo-randomness affects both folded and not folded hash
> distribution, it can not end up in different results.

Yes it would, so to rule out pseudo-random effects the pseudo-
random number generator must be removed.

> 
> You are right that having test with 2^48 values is really interesting,
> but it will take ages on my test machine :)

Try a usable subset; no pseudo-random number generator.
