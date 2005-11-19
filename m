Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVKSGRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVKSGRV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 01:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKSGRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 01:17:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbVKSGRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 01:17:20 -0500
Date: Fri, 18 Nov 2005 22:16:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1
Message-Id: <20051118221659.64515ac0.akpm@osdl.org>
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
>
> eCryptfs
>

If Linux is going to offer a feature like this then people have to be able
to trust it to be quite secure.  What we don't want to happen is to
distribute it for six months and then be buried in reports of
vulnerabilites from cryptography specialists.  Even worse if those reports
lead to exploits.

So I guess what I'm asking is: has this code been reviewed by crypto
experts?  Bearing in mind that it'll be world-class crypto people who will
try to poke holes in it.
