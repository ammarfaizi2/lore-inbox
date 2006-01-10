Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWAJIee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWAJIee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWAJIee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:34:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:41858 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751009AbWAJIed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:34:33 -0500
Date: Tue, 10 Jan 2006 00:38:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dmitry Mishin <dim@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [stable] [PATCH] netlink oops fix due to incorrect error code
Message-ID: <20060110083803.GJ3335@sorel.sous-sol.org>
References: <43C27662.2030400@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C27662.2030400@openvz.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kirill Korotaev (dev@openvz.org) wrote:
> Fixed oops after failed netlink socket creation.
> Wrong parathenses in if() statement caused err to be 1,
> instead of negative value.
> Trivial fix, not trivial to find though.

Thanks, queued to -stable.
-chris
