Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUIWPwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUIWPwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUIWPwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:52:54 -0400
Received: from cathy.bmts.com ([216.183.128.202]:24053 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S266295AbUIWPwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:52:05 -0400
Date: Thu, 23 Sep 2004 11:51:22 -0400
From: Mike Houston <mikeserv@bmts.com>
To: vs@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 (disable repacker)
Message-Id: <20040923115122.4b84f991.mikeserv@bmts.com>
In-Reply-To: <1095945329.6117.25.camel@tribesman.namesys.com>
References: <20040922131210.6c08b94c.akpm@osdl.org>
	<1095945329.6117.25.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 17:15:29 +0400
Vladimir Saveliev <vs@namesys.com> wrote:

> Sorry, please replace reiser4-disable-repacker.patch with the
> attached one.
> 
> >  reiser4 update
> > 
> 
>

Hello, thank you for that. Reversing the old disable repacker patch
from broken-out and applying this one fixed a nasty oops on attempting
to unmount reiser4 for me.
