Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTHBNTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTHBNTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:19:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:47762 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263355AbTHBNTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:19:35 -0400
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paulmck@us.ibm.com
In-Reply-To: <20030802015140.6FE9C2C04F@lists.samba.org>
References: <20030802015140.6FE9C2C04F@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059830126.19819.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 14:15:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-02 at 02:49, Rusty Russell wrote:
> Sure.  But it's not neccessary.  The replacement is cleaner and
> smaller, sure, but it's not worth changing once 2.6 is out.  In 2.7,
> sure.
> 
> I'm happy to accept "no" from Andrew, but not happy to accept "we'll
> just change the API midway through 2.6".

Please distinguish API from ABI. There is no ABI, there is no need for
an ABI.

