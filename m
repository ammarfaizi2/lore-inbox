Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTJLW31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTJLW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:29:27 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:2549 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S261190AbTJLW3Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:29:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre - RAS team
To: "David S. Miller" <davem@redhat.com>, karim@opersys.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
Date: Sun, 12 Oct 2003 23:23:48 +0000
User-Agent: KMail/1.4.1
Cc: jmorris@redhat.com, zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
       bob@watson.ibm.com
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com> <3F86C519.4030209@opersys.com> <20031011103429.5ebe3085.davem@redhat.com>
In-Reply-To: <20031011103429.5ebe3085.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310122323.48885.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 11 October 2003 5:34 pm, David S. Miller wrote:
> On Fri, 10 Oct 2003 10:41:29 -0400
>
> Karim Yaghmour <karim@opersys.com> wrote:
> > The question isn't whether netlink can transfer hundreds of thousands of
> > data units in one fell swoop. The question is: is it more efficient than
> > relayfs at this?
>
> Wrong, it's the queueing model that's important for applications
> like this.

Why is a queuing model relvant to low-level kernel tracing, which is the prime 
target of relayfs? In otherwords why would netlink be the infrastructure of 
choice on which to implenment tracing, say in a GB ethernet driver?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Richard J Moore
IBM Linux Technology Centre
