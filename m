Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbVIZBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbVIZBIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbVIZBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 21:08:35 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:24170 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751591AbVIZBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 21:08:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H2dNI0TL+U+XzbWMYHAIlmyyCNS5Z/wU+91uTre4+fWnA0CEKHJu1jKDg5RjQk9gePJqyuXR4lcoPrfwK9Dbkbu1O3KinqIlbT5EQ8acQvDR4feQiW/xGhTTG05rFFuw7Q56tV4SDRFBx/PaIfXSRdzgeWiL3817Jmz235NO12A=  ;
Message-ID: <433749E8.3060507@yahoo.com.au>
Date: Mon, 26 Sep 2005 11:07:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] atomic_cmpxchg and friends
References: <4334BCF3.1010908@yahoo.com.au> <1127682571.1168.25.camel@localhost.localdomain>
In-Reply-To: <1127682571.1168.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
>+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old,
>new))
>+
>
>Not all X86 has cmpxchg so the code there won't compile for all cases.
>
>

Ah yeah thanks. I guess was supposed to send in Christoph's i386
cmpxchg patch first. I'll take care of that.

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
