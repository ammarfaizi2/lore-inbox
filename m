Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWDSQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWDSQCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWDSQCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:02:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35039 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750982AbWDSQCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:02:34 -0400
Subject: RE: searching exported symbols from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF5154E1@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF5154E1@titanium.secgo.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 18:02:31 +0200
Message-Id: <1145462551.3085.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 18:59 +0300, Antti Halonen wrote:
> > a better way would be then to have a "core" module which is basically
> > collecting these algorithms, and then have the algorithm modules, when
> > they are loaded, register themselves with this core module. (and
> > unregister at unload). It's sort of inside-out with they way you're
> > trying to do it, but it'll work out a lot nicer. Obviously the user of
> > the algorithms can be another module in addition to this core module.
> > (and even register algorithms itself)
> 
> Exactly, I agree 100%. But here's the catch: it's not an option at this
> point in time. 

eh why not? For your module to be ever merged into mainline this change
will need to be done anyway (and it'll save you time as well even on the
short term)

