Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbUKXTFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUKXTFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUKXTCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:02:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:59094 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262814AbUKXTAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:00:40 -0500
Date: Wed, 24 Nov 2004 09:55:17 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
Message-Id: <20041124095517.2be3a105@zqx3.pdx.osdl.net>
In-Reply-To: <1101289960.2337.8.camel@linux.local>
References: <419A9151.2000508@atmos.washington.edu>
	<20041116163257.0e63031d@zqx3.pdx.osdl.net>
	<cone.1100651833.776334.15267.502@pc.kolivas.org>
	<419BA5C4.4020503@atmos.washington.edu>
	<1100722571.20185.9.camel@tux.rsn.bth.se>
	<419BBF57.3040808@atmos.washington.edu>
	<1101289960.2337.8.camel@linux.local>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 10:52:41 +0100
Hans Kristian Rosbach <hk@isphuset.no> wrote:

> On Tue, 2004-11-23 at 19:04, Stephen Hemminger wrote:
> > Also, 2.6.9 has TCP bugs with TSO that can cause panic's.
> > These have been fixed in 2.6.10-rc2.
> 
> Shouldn't this patch be backported and make 2.6.9.1 ?

It is not one patch, but many (as IBM found out). And all the details weren't
worked out until recently. Go ahead and make your own, the problem
is working out what would be in a 2.6.9.1, by the time you did all that
2.6.10 would be out and you would end up doing the work that all the vendors
have to now.
