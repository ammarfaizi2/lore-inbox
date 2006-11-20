Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966048AbWKTQND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966048AbWKTQND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966060AbWKTQND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:13:03 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:23457 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S966048AbWKTQNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:13:01 -0500
Message-ID: <4561D40C.7040306@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 17:13:00 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] WorkStruct: Typedef the work function prototype
References: <4561CC0D.2070900@s5r6.in-berlin.de>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com> <14330.1164037654@redhat.com>
In-Reply-To: <14330.1164037654@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> If so, it should certainly also be used in the declarations and
>> definitions of the work functions.
> 
> Is this what you mean?:
> 
> 	work_func_t do_my_work
> 	{
> 		...
> 	}

That's what I meant. (But now that you wrote it out I'm not so certain
about doing this anymore.)

> 	DECLARE_WORK(my_work, do_my_work);
> 
> 	void do_it(void)
> 	{
> 		schedule_work(&my_work);
> 	}

-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
