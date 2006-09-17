Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWIQDqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWIQDqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 23:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWIQDqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 23:46:30 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:9864 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964952AbWIQDqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 23:46:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3gQKGSVD92jGVpsSMxo7jAmvBaIT54fXgSSR0KjABaSfHBO39LnQNqyDhtwVvivj6eCPyWOBlmhhvGSlxdH73+FcyNeWpaS5b48nWeHqrtkPsJPdU2ZhPxKtMkKdMoCMIc4tPx5BB/QUCzDWSLOJlVLKxU+225QxLysUOCeIfC0=  ;
Message-ID: <450CC50F.2090501@yahoo.com.au>
Date: Sun, 17 Sep 2006 13:46:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, dhowells@redhat.com
Subject: Re: [PATCH 0 of 11] Use SEEK_{SET,CUR,END} instead of hardcoded values
References: <patchbomb.1158455366@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef 'Jeff' Sipek wrote:
> In July, David Howells added SEEK_{SET,CUR,END} definitions to include/linux/fs.h
> 
> The following patches convert offenders which were found by grep'ing the source
> tree.

Looks like a good change to me.

Nitpick, do you need 11 patches to do it? 1 would be fine, I think?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
