Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTJKRkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJKRkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:40:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6017 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263349AbTJKRkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:40:22 -0400
Date: Sat, 11 Oct 2003 10:34:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: karim@opersys.com
Cc: jmorris@redhat.com, zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
       bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Message-Id: <20031011103429.5ebe3085.davem@redhat.com>
In-Reply-To: <3F86C519.4030209@opersys.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<3F859DF1.8000602@opersys.com>
	<20031010005703.0daf3e19.davem@redhat.com>
	<3F86C519.4030209@opersys.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 10:41:29 -0400
Karim Yaghmour <karim@opersys.com> wrote:

> The question isn't whether netlink can transfer hundreds of thousands of
> data units in one fell swoop. The question is: is it more efficient than
> relayfs at this?

Wrong, it's the queueing model that's important for applications
like this.
