Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275045AbTHFLQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275046AbTHFLQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:16:37 -0400
Received: from home.wiggy.net ([213.84.101.140]:51840 "EHLO
	thunder.home.wiggy.net") by vger.kernel.org with ESMTP
	id S275045AbTHFLQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:16:36 -0400
Date: Wed, 6 Aug 2003 13:16:34 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Cc: bert hubert <ahu@ds9a.nl>
Subject: Re: nfs/nfsd gets stuck on a write
Message-ID: <20030806111634.GG703@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
	bert hubert <ahu@ds9a.nl>
References: <20030806104612.GB703@wiggy.net> <20030806110215.GA30936@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806110215.GA30936@outpost.ds9a.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously bert hubert wrote:
> I've had problems like that go away by explicitly mounting -o tcp. 

Mounting with -o tcp does indeed seem to be a working work-around. It
does feel a lot more sluggish/high latency than udp though.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

