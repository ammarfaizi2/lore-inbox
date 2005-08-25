Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVHYI7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVHYI7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVHYI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:59:31 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:63089 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964883AbVHYI7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:59:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p8ggyvdwd9syZSI8U5L/ze7X6pzpaNFhDvOGyPHRPGe1wwX+/fV9Wp1SNPUbw3BMcXwY9U1mKkj9lEpV+zPm2a3nHKVQohzPpDeY+nTSo8yjv+EFagaHVf8ju6eBnI9XmjRdapmikly7HwFFVWeVPY5W9hxXx9wxq0IXtp1h+2Q=
Message-ID: <4fec73ca050825015970a57910@mail.gmail.com>
Date: Thu, 25 Aug 2005 10:59:29 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Environment variables inside the kernel?
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1r7cmtjm7.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	 <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	 <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
	 <4fec73ca05081811488ec518e@mail.gmail.com>
	 <m1fyt3ueh9.fsf@ebiederm.dsl.xmission.com>
	 <4fec73ca05082202051231bf15@mail.gmail.com>
	 <m1r7cmtjm7.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just a bit of food for thought.  There seem to be two different kinds
> of workloads for non-local filesystems.  Bandwidth intensive workloads
> where files are read and written.  Cache intensive workloads (like
> kernel compiles) where performance directly relates to how
> efficiently you can make use of the page cache, and not get buried
> in cache contention.

Yes, those performance factors have to been taken in account. The
bandwith intensive workloads depends on the implementation of the
filesystem. Note that I am not involved in the internal details of
this filesystem, my goal is to integrate it in the Linux kernel.

The usage of cache memory in this distributed schemas is complicated.
Probably it will be necessary to implement protocols to ensure cache
coherency and consistency.

Hum... it seems that we are going away from environment variables :)

-- 
Guillermo
