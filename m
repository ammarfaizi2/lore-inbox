Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUHPKPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUHPKPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUHPKNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:13:42 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:17103 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267510AbUHPKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:12:59 -0400
Message-ID: <412088A5.6010106@tungstengraphics.com>
Date: Mon, 16 Aug 2004 11:12:53 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com> <20040816094622.GA31696@devserv.devel.redhat.com>
In-Reply-To: <20040816094622.GA31696@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, Aug 16, 2004 at 10:43:34AM +0100, Keith Whitwell wrote:
> 
>>If we can manage to support FreeBSD and Linux from one codebase, surely 
>>supporting 2.4 and 2.6 isn't too difficult?
> 
> 
> It for sure is possible.
> However the DRM codebase proves that it's incapable of even doing BSD
> support properly (eg without the right abstractions but instead fouling up
> the entire codebase to the point of unreadability). That gives me no
> confidence the "keep 2.4 support" will not turn out to be at least as
> ugly/broken/wrong.

Well...  I think there's some confusion regarding how much of the macro-itis 
in the current DRM is related to support for freebsd and how much is just a 
reasonable idea taken too far.

Most of the abstractions that you're complaining about existed prior to the 
addition of freebsd support, and right now, Dave Airlie is doing good work 
returning the codebase to something less obscure.

Anyway, as far as I'm concerned 2.4 support is of primary importance to the 
people who actually use this code, so I will work to see it retained.

Keith

