Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUCECSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 21:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUCECSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 21:18:55 -0500
Received: from mx02.qsc.de ([213.148.130.14]:17900 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262159AbUCECSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 21:18:54 -0500
Message-ID: <4047E231.60304@trash.net>
Date: Fri, 05 Mar 2004 03:13:05 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Strait <quadong@users.sourceforge.net>
CC: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matching any helper in ipt_helper.c
References: <Pine.LNX.4.60.0403031947450.8957@dsl093-017-216.msp1.dsl.speakeasy.net> <40469E10.7080100@trash.net> <Pine.LNX.4.60.0403032150000.8957@dsl093-017-216.msp1.dsl.speakeasy.net> <4046BFB9.809@trash.net> <Pine.LNX.4.60.0403041500280.10634@dsl093-017-216.msp1.dsl.speakeasy.net> <4047A42E.6080307@trash.net> <Pine.LNX.4.60.0403041821010.21790@dsl093-017-216.msp1.dsl.speakeasy.net>
In-Reply-To: <Pine.LNX.4.60.0403041821010.21790@dsl093-017-216.msp1.dsl.speakeasy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Strait wrote:
> Silly me, I assumed that the error was generated in user space.  Ok.  In
> that case, let's forget translating "any" to "", because that just makes
> the output of "iptables -L" confusing.  Sound good?
>

I actually meant translate in both direction. But no problem, I'm going
to make a patch for iptables myself, if Martin is fine with it we can
remove the childlevel match.

Thanks.

Patrick
