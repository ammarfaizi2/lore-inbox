Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946422AbWJTNkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946422AbWJTNkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946423AbWJTNkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:40:21 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45077 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946422AbWJTNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:40:19 -0400
Message-ID: <4538D1C1.1080106@de.ibm.com>
Date: Fri, 20 Oct 2006 15:40:17 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <npiggin@suse.de>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	<4534FA99.2080009@fr.ibm.com> <20061017112931.80ce9ca4.akpm@osdl.org>
In-Reply-To: <20061017112931.80ce9ca4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Tue, 17 Oct 2006 17:45:29 +0200
> Cedric Le Goater <clg@fr.ibm.com> wrote:
>
>   
>>> +mm-fix-pagecache-write-deadlocks.patch
>>>       
> <looks>
>
> I think it might actually be that simple.  I expected a lot more fuss than
> that.
>
>   
This actually makes it compile&run again. Therefore I vote for inclusion.
I will look into Nick's suggestion of replacing it by a non-atomic 
variant later on, after fixing a page refcounting issue with xip and cow 
that was introduced by Nicks changes.
Acked-by: Carsten Otte <cotte@de.ibm.com>

