Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbULUIai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbULUIai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 03:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbULUIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 03:30:38 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:16103 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261609AbULUIae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 03:30:34 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 2.6.9 NAT problem
To: Bill Davidsen <davidsen@tmr.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 21 Dec 2004 09:34:07 +0100
References: <fa.en17uqu.1r1odgm@ifi.uio.no> <fa.b00sk8v.12lus29@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CgfT5-0000Zh-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Antonio Pérez wrote:

>> add this:
>> echo 0 > /proc/sys/net/ipv4/tcp_bic
>> echo 0 > /proc/sys/net/ipv4/tcp_ecn
>> echo 0 > /proc/sys/net/ipv4/tcp_vegas_conf_avoid
> 
> I've seen this and similar advice for other problems, and have disabled=
>  
> ecn for several systems with networking ailments myself. Would it be
> better to have some of these off by default rather than have multiple
> versions of these problems appear into the future?

Disabeling ecn is a workaround for b0rken firewalls and may result in
using more bandwidth than nescensary. If disabeling ecn helps, dump the
firewall and get something that supports basic internet standards (or
ask the owner to do this).
