Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSBDMdG>; Mon, 4 Feb 2002 07:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSBDMc4>; Mon, 4 Feb 2002 07:32:56 -0500
Received: from tomts23-srv.bellnexxia.net ([209.226.175.185]:23013 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288949AbSBDMcs>; Mon, 4 Feb 2002 07:32:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
Date: Mon, 4 Feb 2002 07:32:46 -0500
X-Mailer: KMail [version 1.3.2]
Cc: arjanv@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204123247.22C3E9000@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> Ingo Molnar wrote:
>> 
>> On Sun, 3 Feb 2002, Ed Tomlinson wrote:
>> 
>> > One point that seems to get missed is that a group of java threads,
>> > posix threads or sometimes forked processes combine to make an
>> > application. [...]
>> 
>> yes - but what makes them an application is not really the fact that they
>> share the VM (i can very much imagine thread-based login servers where
>> different users use different threads - a single application as well?),
>> but the intention of the application designer, which is hard to guess.
> 
> sharing the same Thread Group ID would be a very obvious quantity to
> check,
> and would very much show the indication of the application author.

I Tried this.  Looks like not all (many?) apps actually use this.

Ed
