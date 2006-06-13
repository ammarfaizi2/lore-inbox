Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWFMWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWFMWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWFMWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:00:57 -0400
Received: from relay02.pair.com ([209.68.5.16]:2057 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S932356AbWFMWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:00:56 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 13 Jun 2006 17:00:53 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "Brian F. G. Bidulock" <bidulock@openss7.org>
cc: Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
In-Reply-To: <20060613154031.A6276@openss7.org>
Message-ID: <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
 <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org>
 <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Brian F. G. Bidulock wrote:

> Daniel,
>
> On Tue, 13 Jun 2006, Daniel Phillips wrote:
>>
>> This has the makings of a nice stable internal kernel api.  Why do we want
>> to provide this nice stable internal api to proprietary modules?
>
> Why not?  Not all non-GPL modules are proprietary.  Do we lose
> something by making a nice stable api available to non-derived
> modules?

Look out for that word (stable). Judging from history (and sanity), 
arguing /in favor of/ any kind of stable module API is asking for it.

At least some of us feel like stable module APIs should be explicitly 
discouraged, because we don't want to offer comfort for code 
that refuses to live in the tree (since getting said code into the tree is 
often a goal).

I'm curious now too - can you name some non-GPL non-proprietary modules we 
should be concerned about? I'd think most of the possible examples (not 
sure what they are) would be better off dual-licensed (one license 
being GPL) and in-kernel.

Thanks,
Chase
