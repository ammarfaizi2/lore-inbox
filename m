Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSJOO7M>; Tue, 15 Oct 2002 10:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJOO7M>; Tue, 15 Oct 2002 10:59:12 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:60916 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262937AbSJOO7L>; Tue, 15 Oct 2002 10:59:11 -0400
Date: Tue, 15 Oct 2002 11:05:01 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015110501.B11395@redhat.com>
References: <3DAB46FD.9010405@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAB46FD.9010405@watson.ibm.com>; from nagar@watson.ibm.com on Mon, Oct 14, 2002 at 06:36:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 06:36:45PM -0400, Shailabh Nagar wrote:
> As of today, there is no scalable alternative to poll/select in the 2.5
> kernel even though the topic has been discussed a number of times
> before. The case for a scalable poll has been made often so I won't
> get into that.

Have you bothered addressing the fact that async poll scales worse than 
/dev/epoll?  That was the original reason for dropping it.

		-ben
