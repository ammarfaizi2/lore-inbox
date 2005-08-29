Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVH2XzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVH2XzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVH2XzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:55:20 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:62392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932083AbVH2XzU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:55:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=J5b03hXwJ5GIKYdJsA8Yl1LPs5dtlMZNpYWRDN3zWSQ5UKbDn78v2pL9mP313MdIOX5xCZ3Tf7Liv8zitPV0tPx/9wZLRJeKs4wlUT1Fd4qsWQ8VuFupOvCFWZOWvz6gIyKsYF8blUQz345zV6H9Tziqlklq/RQ3zxvE7kmlApU=
Date: Tue, 30 Aug 2005 01:55:13 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: stephane.wirtel@belgacom.net, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Message-Id: <20050830015513.62ee2c0c.diegocg@gmail.com>
In-Reply-To: <9a8748490508291634416a18bc@mail.gmail.com>
References: <20050829231417.GB2736@localhost.localdomain>
	<20050830012813.7737f6f6.diegocg@gmail.com>
	<9a8748490508291634416a18bc@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.1+svn (GTK+ 2.8.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 30 Aug 2005 01:34:25 +0200,
Jesper Juhl <jesper.juhl@gmail.com> escribió:

> I don't see why we should break a bunch of drivers by doing that.
> Much better, in my oppinion, to fix the few remaining drivers still
> using check_region and *then* kill it. Even unmaintained drivers may

I'd usually agree with you, but check_region has been deprecated for so many
time; I was just wondering myself if people will bother to fix the remaining
drivers without some "incentive" 
