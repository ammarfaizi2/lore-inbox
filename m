Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTLJJky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTLJJky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:40:54 -0500
Received: from levante.wiggy.net ([195.85.225.139]:5000 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262458AbTLJJkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:40:53 -0500
Date: Wed, 10 Dec 2003 10:40:51 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210094051.GA14619@wiggy.net>
Mail-Followup-To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org> <20031210002737.GA27208@localhost> <3FD67005.6060606@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD67005.6060606@tupshin.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Tupshin Harper wrote:
> This is not true. LVM2 can read the LVM1 format, but it cannot 
> communicate with non-dm interfaces in 2.4.x. This means that you need to 
> run lvm1 on 2.4 and lvm2 on 2.6 unless you patch 2.4 with dm.

And unless my memory is failing me all distros ship tools that will
detect which interface your system has and call the right tool for you.
That was already needed for lvm1 which went through several ioctl
interfaces and continues to work fine for lvm2. Which means this 
is pretty much a non-issue.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

