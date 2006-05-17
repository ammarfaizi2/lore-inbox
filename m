Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWEQHN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWEQHN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWEQHN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:13:59 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:61835 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932458AbWEQHNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:13:55 -0400
X-IronPort-AV: i="4.05,136,1146466800"; 
   d="scan'208"; a="278066099:sNHT34427596"
To: "David S. Miller" <davem@davemloft.net>
Cc: kaber@trash.net, sfrost@snowman.net, azez@ufomechanic.net, willy@w.ods.org,
       gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
X-Message-Flag: Warning: May contain useful information
References: <20060515204142.GO7774@kenobi.snowman.net>
	<20060515210342.GP7774@kenobi.snowman.net>
	<446AC1FB.5070406@trash.net>
	<20060517.000957.45395448.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 May 2006 00:13:52 -0700
In-Reply-To: <20060517.000957.45395448.davem@davemloft.net> (David S. Miller's message of "Wed, 17 May 2006 00:09:57 -0700 (PDT)")
Message-ID: <ada1wut86of.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2006 07:13:54.0195 (UTC) FILETIME=[74AE2630:01C67981]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I'm feeling particularly dense today... but what is the
    David> relative precedence of '&' vs '&&'?

& binds tighter than &&.  "man operator" can be your friend...

    David> I've been told that if you have to look up C operator
    David> precedence, don't bother and add parenthesis instead :) -

Probably a good rule though.

 - R.
