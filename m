Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWD1V6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWD1V6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 17:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWD1V6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 17:58:04 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:10174 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S1751459AbWD1V6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 17:58:03 -0400
Date: Fri, 28 Apr 2006 23:58:24 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060428215824.GA2922@fargo>
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	David Vrabel <dvrabel@cantab.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com> <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo> <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Apr 28 at 02:59:01, Pekka J Enberg wrote:
> Here are some suggestions for coding style cleanups:

Couple of questions,

>   - Use dev_{dbg,err,info,warn} for logging

Cannot, i need a "struct device" and most of the
there's only access to a "struct net_device". Am i
missing something? 

>   - Use proper naming convention for things like Length and pPHYParam

What's the convention for these names?

Thanks,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
