Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWDZVFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWDZVFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWDZVFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:05:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16796 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932463AbWDZVFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:05:44 -0400
Date: Wed, 26 Apr 2006 23:05:43 +0200
From: Martin Mares <mj@ucw.cz>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-ID: <mj+md-20060426.210319.10242.atrey@ucw.cz>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	C++ has how many additional reserved words? I believe the list is delete,
> friend, private, protected, public, template, throw, try, and catch.
> Renaming every symbol that currently has a name from this list to the
> corresponding name with a trailing underscore is an easily understood
> consistent change.

... which, for the point of view of people developing most parts of the
kernel (and thus not caring about C++ much) just makes the names ugly.
When some struct member describes a device class the device belongs to,
calling it anything else than "class" is silly.

But yes, the C++ modules can redefine such things by macros when
including kernel headers.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Linux vs. Windows is a no-WIN situation.
