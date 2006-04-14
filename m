Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWDNE7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWDNE7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 00:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWDNE7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 00:59:49 -0400
Received: from ozlabs.org ([203.10.76.45]:54931 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965075AbWDNE7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 00:59:49 -0400
Subject: Re: modprobe bug for aliases with regular expressions
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060413233518.GA7597@kroah.com>
References: <20060413233518.GA7597@kroah.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 14:59:30 +1000
Message-Id: <1144990770.31267.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 16:35 -0700, Greg KH wrote:
> Recently it's been pointed out to me that the modprobe functionality
> with aliases doesn't quite work properly for some USB modules.

Sorry, my bad.  I got a patch for this a while ago from Sam Morris.
Originally noone was using ranges in [].

This is fixed in 3.3-pre1.  I should release 3.3 proper sometime this
weekend.

Thanks for the poke!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

