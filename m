Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDSOWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDSOWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDSOWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:22:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWDSOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:22:37 -0400
Subject: Re: searching exported symbols from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 16:22:35 +0200
Message-Id: <1145456555.3085.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 15:44 +0300, Antti Halonen wrote:
> Hi,
> 
> Apologies if I posted this question to wrong place.
> 
> Here's the thing: when loading my module 'a', I want to search modules
> list to check if module 'b' is presents, and if it is, initialize my
> function pointers to the functions module b has exported. Or at least
> search symbols from module b, whatever. The main question is; how to
> locate modules 
> by name from my module a?
> 
> Is this doable? Can anyone give me pointers? 
> 
> Sorry for posting such a stupid question, but I didn't run into
> satisfactory when searching the archive & many of the functions which
> would have resolved this are apparently not exported anymore.

they still are... but.. very often if you want to do this you have a
crooked design, you were very vague about what you are really trying to
achieve (you only described your solution, not the problem)

