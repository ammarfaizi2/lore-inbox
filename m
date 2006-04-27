Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWD0Hti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWD0Hti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWD0Hti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:49:38 -0400
Received: from twin.jikos.cz ([213.151.79.26]:5030 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932434AbWD0Hth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:49:37 -0400
Date: Thu, 27 Apr 2006 09:49:34 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: RE: C++ pushback
In-Reply-To: <1146082192.11123.4.camel@bip.parateam.prv>
Message-ID: <Pine.LNX.4.58.0604270945340.20938@twin.jikos.cz>
References: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
 <1146082192.11123.4.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Xavier Bestel wrote:

> > 	C++ has how many additional reserved words? I believe the list is
> > delete, friend, private, protected, public, template, throw, try, and
> > catch.
> You forgot namespace, mutable, new, class, const_cast, dynamic_cast,
> static_cast, reinterpret_cast, explicit, true, false, operator, typeid,
> typename and virtual. Maybe I forgot some (interface ?). Probably some
> new ones will appear.

Please also don't forget that C is not a proper subset of C++ (i.e. the 
kernel might not be compilable by C++ compiler at all), so just renaming 
the variables which have names clashing with C++ reserved words might not 
be enough.

-- 
JiKos.
