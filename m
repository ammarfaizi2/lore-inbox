Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSKZGDG>; Tue, 26 Nov 2002 01:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSKZGDG>; Tue, 26 Nov 2002 01:03:06 -0500
Received: from ns.suse.de ([213.95.15.193]:22545 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266186AbSKZGDF>;
	Tue, 26 Nov 2002 01:03:05 -0500
Date: Tue, 26 Nov 2002 07:10:21 +0100
From: Andi Kleen <ak@suse.de>
To: Patrick Finnegan <pat@purdueriots.com>, Andi Kleen <ak@suse.de>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1
Message-ID: <20021126061021.GA17959@wotan.suse.de>
References: <p73u1i4ub3g.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0211260105400.7540-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211260105400.7540-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One reason I can think of is that it prevents 'stupid things' happening
> under a copy of UML from killing the OS UML is running under... Eg. if a
> process is running under UML because it's not trusted and then turns into
> a forkbomb, you don't want that taking down the host OS.

You could limit that with an appropiate ulimit.

Also a 'mm-bomb' could be similarly deadly without appropiate host limits.

-Andi
