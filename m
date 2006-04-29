Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWD2HaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWD2HaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWD2HaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:30:21 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:10926 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S1751850AbWD2HaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:30:20 -0400
Date: Sat, 29 Apr 2006 09:30:40 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060429073040.GB7946@fargo>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com> <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo> <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <20060428215824.GA2922@fargo> <20060428154251.23fcfc41@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060428154251.23fcfc41@localhost.localdomain>
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

Hi Stephen,

On Apr 28 at 03:42:51, Stephen Hemminger wrote:
> It is stored if you use SET_NETDEV_DEV() macro prior to registration.
> Perhaps we need some netdev_{dbg,err,info,warn} macros?

Maybe. A grep reveals that no network driver is using still the
dev_* loggin macros.

> static inline struct device * netdev_dev(struct net_device *netd)
> {
> 	return netd->class_dev.dev;
> }

ok. thanks

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
