Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVCGVyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVCGVyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVCGV1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:27:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:21894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261770AbVCGVL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:11:59 -0500
Date: Mon, 7 Mar 2005 13:11:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-Id: <20050307131113.0fd7477e.akpm@osdl.org>
In-Reply-To: <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050304160451.4c33919c.akpm@osdl.org>
	<1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307123118.3a946bc8.akpm@osdl.org>
	<1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> I'm having trouble testing it, though --- I seem to be getting livelocks
>  in O_DIRECT running 400 fsstress processes in parallel; ring any bells? 

Nope.  I dont think anyone has been that cruel to ext3 for a while.
I assume this workload used to succeed?
