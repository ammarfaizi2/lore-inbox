Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWJDGJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWJDGJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWJDGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:09:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:17697 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030328AbWJDGJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:09:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dbaBPPIEet8b/4wmZTb8SwmgB+FZTaKfQDXl8msbVwYgxcMI+QfS7+O2NxIIVRi9ejazWDrBUjqQ9HP+N+SwK4+xGjYxRLZzqun2Eq8OVOiaQkk2wX+XkOflZetZPyEapxb/deMPVX/aL++3ZNY5wvEuKEG6KF10zWLIHvITotI=
Message-ID: <a36005b50610032309u2a8b5797x43e5cce2fbd1d18e@mail.gmail.com>
Date: Tue, 3 Oct 2006 23:09:15 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>
In-Reply-To: <20060923042350.GA24099@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru>
	 <20060922122207.3b716028.akpm@osdl.org>
	 <20060923042350.GA24099@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> The only two things missed in patchset after his suggestions are
> new POSIX-like interface, which I personally consider as very unconvenient,

This means you really do not know at all what this is about.  We
already have these interfaces.  Several of them and there will likely
be more.  These are interfaces for functionality which needs the new
event notification.  There is *NO* reason whatsoever to not make this
