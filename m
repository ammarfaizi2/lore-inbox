Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272542AbTHKM7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTHKM6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:58:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31378 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272542AbTHKM6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:58:35 -0400
Date: Fri, 8 Aug 2003 15:50:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend fails under load
Message-ID: <20030808135037.GE6914@openzaurus.ucw.cz>
References: <1060178056.1390.4.camel@litshi.luna.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060178056.1390.4.camel@litshi.luna.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Under kernel 2.6.0-test2 I get the behaviour that when trying to suspend
> under load, I get all the way to the black screen, after which I am
> supposed to see the writing pages to disk message.
> Instead I see an error message flashing by to fast to read and

that's easy: add mdelays to suspend.c :-)
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

