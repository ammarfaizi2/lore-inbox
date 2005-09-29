Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVI2SZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVI2SZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVI2SZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:25:10 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:2460 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbVI2SZI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lho+JzPhEufIWdIIAVACrvr+5zlth4k0OXXeO4LrHoh7hJWWkALjVU/3W1TjIdnLBblOd1NrfudvxAF7ncodef8q6RVAQJDW7GJokzKC9HjVgXZoBd2fXyqRBBvleOFcMKhEzNL9zncc2M9n2DgFDSjlbtOtI704xhVywbsK2xU=
Message-ID: <12c511ca05092911257ce58aef@mail.gmail.com>
Date: Thu, 29 Sep 2005 11:25:07 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
To: Joachim Bremer <joachim.bremer@web.de>
Subject: Re: 2.6.14-rcX: strange timestamp on ping
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1976447075@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1976447075@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Joachim Bremer <joachim.bremer@web.de> wrote:
>
> Hello,
>
> since very early in the 2.6.14 process ping or traceroute gives very
> strange timestamps. eg
> 64 bytes from 192.168.0.1: icmp_seq=1 ttl=127 time=4294971590970 ms
>

Similar on ia64, but I don't see the problem across the network (either to
or from my 2.6.14-rc2 system).  But I do see an odd time for localhost!
$ ping localhost
PING linux-t10 (127.0.0.1) 56(84) bytes of data.
64 bytes from linux-t10 (127.0.0.1): icmp_seq=0 ttl=64 time=4294967 ms
64 bytes from linux-t10 (127.0.0.1): icmp_seq=1 ttl=64 time=4294967 ms

-Tony
