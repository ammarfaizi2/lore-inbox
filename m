Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJMRbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJMRbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 13:31:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261750AbTJMRbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 13:31:48 -0400
Date: Mon, 13 Oct 2003 10:25:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard J Moore <rasman@uk.ibm.com>
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Message-Id: <20031013102520.0671a69d.davem@redhat.com>
In-Reply-To: <200310122323.48885.rasman@uk.ibm.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<3F86C519.4030209@opersys.com>
	<20031011103429.5ebe3085.davem@redhat.com>
	<200310122323.48885.rasman@uk.ibm.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003 23:23:48 +0000
Richard J Moore <rasman@uk.ibm.com> wrote:

> Why is a queuing model relvant to low-level kernel tracing, which is the prime 
> target of relayfs?

Because you need a queueing model any time there is a sender of
information and a receiver.  In this case it's the kernel events
and the event logging process.

