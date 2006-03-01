Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWCACMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWCACMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWCACMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:12:15 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:9588 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932654AbWCACMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:12:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LbNn7ibN6xyv/9GDBqLSrL6A7EcHYFfY945WlMAyNeY15PVvV8c3z1KiWQc+mghPqdrIQVKN5LduwefJKe9xvtcm4p0ZlngU5cxW/jMsLazbV6kGeEBJS6GkhIYBaOvwM0iRAb8vQH5qb8+0XXirAp6kNFMSQ+7MhKIyLbbTk2I=  ;
Message-ID: <440502F3.7020203@yahoo.com.au>
Date: Wed, 01 Mar 2006 13:12:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] allow hard links to directories, opt-in for any
 filesystem
References: <200602281657.k1SGvKFk026965@laptop11.inf.utfsm.cl>
In-Reply-To: <200602281657.k1SGvKFk026965@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Joshua Hudson wrote:
>>
>>>Patch seems to work, might want more testing.
>>>It probably should not be applied without a discussion, especially
>>>as no filesystem in kernel tree wants this. I am working on a fs that does.
> 
> 
>>This is backwards I think. This is not disallowed because there are
>>no filesystems that want it. Linux doesn't want it so it is disallowed
>>by the vfs.
> 
> 
> Right.
> 
> 
>>You have to put forward a case for why we want it, rather than show us
>>your filesystem that "wants" it. Right?
> 
> 
> Nope.

What do you mean nope?

I know why unix didn't allow loops in the filesystem tree. I'm just
saying that you have to justify a feature before adding it. If he was
able to nicely solve problems with loops and show some application
that benefits from it, then it could be considered for Linux.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
