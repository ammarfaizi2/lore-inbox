Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWJHKAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWJHKAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWJHKAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:00:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751009AbWJHKAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:00:44 -0400
Subject: Re: OT: linux-kernel list and greylisting
From: David Woodhouse <dwmw2@infradead.org>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       Michael Obster <lkm@obster.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610020940010.31384@mtl.rackplans.net>
References: <451BFF6F.2050602@obster.org>
	 <200609281946.11845.m.kozlowski@tuxland.pl>
	 <Pine.LNX.4.64.0610020940010.31384@mtl.rackplans.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 11:00:43 +0100
Message-Id: <1160301643.5522.1.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 09:41 -0400, Gerhard Mack wrote:
> If you absolutely need to graylist (I have my doubts about it's 
> effectiveness) then whitelist vger.kernel.org. 

Any half-sensible greylisting implementation would be exempting
vger.kernel.org as soon as it's observed to retry its _first_ mail,
anyway.

Greylisting done _stupidly_, where it keeps delaying mail from a given
host even after it's known to queue and retry, would be a problem. But
done sensibly it's fine.

-- 
dwmw2

