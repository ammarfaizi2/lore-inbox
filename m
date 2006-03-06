Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752457AbWCFWxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbWCFWxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbWCFWxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:53:10 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:53615 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752457AbWCFWxI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:53:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jIEiilaeJRxYG9ygvo2+VMzVIvhz+qBEqyKZkpl/WpuS8HzO509uAuWR8iRec+K4qa4YcsRbL5WWdksY1b/c50t41IvviJYPE3jaFAR1LxXaY6uLSQn5wmFBXX7LD9vM7i4/JwezmTowKWp1qbtktsBZi4r17RtNtk0AcsqOAEA=
Message-ID: <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
Date: Mon, 6 Mar 2006 14:53:07 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Benjamin LaHaise" <bcrl@kvack.org>
Subject: Re: Status of AIO
Cc: "Dan Aloni" <da-x@monatomic.org>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060306211854.GM20768@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306062402.GA25284@localdomain>
	 <20060306211854.GM20768@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
> Socket AIO is not supported yet, but it is useful to get user requests to
> know there is demand for it.

I don't think the POSIX AIO nor the kernel AIO interfaces are suitable
for sockets, at least the way we can expect network traffic to be
handled in the near future.  Some more radical approaches are needed. 
I'll have some proposals which will be part of the talk I have at OLS.
