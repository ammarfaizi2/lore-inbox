Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbUKELk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUKELk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbUKELk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:40:29 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:19414 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262652AbUKELkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:40:20 -0500
Date: Fri, 5 Nov 2004 12:40:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Sven Schuster <schuster.sven@gmx.de>
Cc: foo@porto.bmb.uga.edu, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bad UDP checksums with 2.6.9
Message-ID: <20041105114015.GB10276@merlin.emma.line.org>
Mail-Followup-To: Sven Schuster <schuster.sven@gmx.de>,
	foo@porto.bmb.uga.edu, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20041104054838.GC12763@porto.bmb.uga.edu> <20041104062834.GE12763@porto.bmb.uga.edu> <20041104173929.GA24782@zion.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104173929.GA24782@zion.homelinux.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schuster schrieb am 2004-11-04:

> did you see today's postings from Matthias Andree on this topic??
> It turned out that ip_conntrack_amanda changed some packets and
> that's why the UDP checksum was wrong. It seems like ip_conntrack_amanda
> is build into the kernel on one of your machines.
> 
> See
> http://marc.theaimsgroup.com/?l=linux-net&m=109957086306388&w=2
> http://marc.theaimsgroup.com/?l=linux-net&m=109957086416037&w=2

Turns out my fix was the wrong one, check this instead:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109960579302508&w=2

-- 
Matthias Andree
