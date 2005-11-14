Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVKNRva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVKNRva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVKNRva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:51:30 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:64428 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751204AbVKNRva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:51:30 -0500
Message-ID: <4378CE9B.9020802@rtr.ca>
Date: Mon, 14 Nov 2005 12:51:23 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Badari Pulavarty <pbadari@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
References: <4378ADB2.7040905@rtr.ca>	 <1131982550.2821.41.camel@laptopd505.fenrus.org>  <4378B1FB.1060201@rtr.ca> <1131987398.24066.7.camel@localhost.localdomain> <4378C626.4030107@rtr.ca> <4378CD12.9010606@rtr.ca>
In-Reply-To: <4378CD12.9010606@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Another intriguing observation:
> 
> If I do my file copy test from files that are already cached,
> then the data usually gets committed to disk more or less
> right away.

And even in that case, /proc/meminfo still shows the memory
as "Dirty", until a "sync" is done.  Why is that?
