Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTE2K7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTE2K7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:59:12 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:57511 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262144AbTE2K7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:59:10 -0400
Date: Thu, 29 May 2003 12:14:31 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
Message-ID: <20030529111431.GA19994@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"ismail (cartman) donmez" <kde@myrealbox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com> <200305282222.42227.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305282222.42227.kde@myrealbox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 10:22:42PM +0300, ismail (cartman) donmez wrote:

 > Quite true. But there are bugs at kernel bugzilla which
 > 
 > 1- People care about it being fixed
 > 2- Tests beta kernels to see if its fixed
 > 3- Reports success/failures
 > 
 > But still these bugs are unresolved. I do not say/mean kernel hackers do not 
 > care them or something like that but it would be better to get these kind of 
 > bugs ( with user base who tests them ) fixed before pre-2.6 releases.

Quite a lot of the 'xxx driver does not compile' bugs in bugzilla
may actually have been filed by people just doing coverage testing
to see what actually compiles and what doesn't.
This does unfortunatly make it harder to see at first glance which
drivers are actually still being used by users. The fact that quite
a few of them have no follow-ups does suggest however that no-one who
actually has the hardware cares enough to keep pushing to get things
fixed.  Moving a bunch of these under a CONFIG_BROKEN could be a useful
thing to seperate the wheat from the chaff.

		Dave

