Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUJZX60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUJZX60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbUJZX60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:58:26 -0400
Received: from levante.wiggy.net ([195.85.225.139]:36781 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261552AbUJZX6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:58:15 -0400
Date: Wed, 27 Oct 2004 01:58:12 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Dominik Karall <dominik.karall@gmx.net>, earny@net4u.de,
       linux-kernel@vger.kernel.org
Subject: Re: Neighbour table overflow.
Message-ID: <20041026235812.GD516@wiggy.net>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Dominik Karall <dominik.karall@gmx.net>, earny@net4u.de,
	linux-kernel@vger.kernel.org
References: <200410261939.33541.dominik.karall@gmx.net> <200410262352.20806.earny@net4u.de> <200410270011.28818.dominik.karall@gmx.net> <20041026160642.605f7fd7.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026160642.605f7fd7.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously David S. Miller wrote:
> You probably have a huge number of machines on your subnet.

I got the same error recently on a router running 5 subnets ranging
from /25 to /26 sizes. More annoyingly the interface stopped working
after that message until I did an ifdown && ifup on it. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
