Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbULTID0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbULTID0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbULTIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:02:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:35208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261490AbULTHNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:13:18 -0500
Date: Sun, 19 Dec 2004 23:12:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: lista4@comhem.se
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mr@ramendik.ru,
       kernel@kolivas.org, riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Message-Id: <20041219231250.457deb12.akpm@osdl.org>
In-Reply-To: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1>
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa <lista4@comhem.se> wrote:
>
> Would be nice though if someone else could verify...

Well I'd love to, but afaik the only workloads which we currently know of
involve complex userspace apps which I have no experience running.

Did anyone come up with a simple step-by-step procedure for reproducing the
problem?  It would be good if someone could do this, because I don't think
we understand the root cause yet?
