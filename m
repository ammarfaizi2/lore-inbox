Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUFWRDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUFWRDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUFWRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:03:33 -0400
Received: from www.nute.net ([66.221.212.1]:39820 "EHLO mail.nute.net")
	by vger.kernel.org with ESMTP id S266233AbUFWRCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:02:39 -0400
Date: Wed, 23 Jun 2004 17:02:39 +0000
From: Mikael Bouillot <xaajimri@corbac.com>
To: linux-kernel@vger.kernel.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: Forcedeth driver bug
Message-ID: <20040623170239.GA12050@mail.nute.net>
References: <20040623142936.GA10440@mail.nute.net> <40D99A08.90707@ThinRope.net> <40D9A857.5040901@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D9A857.5040901@gmx.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> forcedeth_gigabit_try19.txt is the most recent one.

  OK, I've tried forcedeth_gigabit_try19 and I still get the same
problem. The only difference is a "bad: scheduling while atomic!" in the
syslog, but I still get stuck packets.

  I've also tried reverting to the older XT-PIC and again, no
improvement.

  I'll now try to work my way through debugging the problem myself. I've
got limited experience with kernel hacking, but I'll learn along the way
:-) If anyone has got any new information or suggestion, I would like to
hear about it.

  Mikael

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
