Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUDXX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUDXX6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 19:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUDXX6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 19:58:25 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:33931 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261988AbUDXX6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 19:58:24 -0400
Message-ID: <408AFF1C.903@yahoo.com.au>
Date: Sun, 25 Apr 2004 09:58:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <Fabian.Frederick@skynet.be>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE throughput in 2.6 - it's good!
References: <1082820563.2268.10.camel@bluerhyme.real3>
In-Reply-To: <1082820563.2268.10.camel@bluerhyme.real3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> 	Here's what we can call a server direction.2.6 is unbeatable there due
> to IO scheduler (i.e. As-iosched, cfq and noop rock'n'roll)

Well, which one were you using just now? AS I assume?

> 
> 	There are no good conclusions at all although ,at this state of
> development, IMHO, 2.4 seems more 'client friendly' and 2.6 server
> oriented in this chapter.

IO scheduler wise, AS should be good for "clients" (ie. desktop)
because it is the desktop where AS's possible small throughput
regressions are not a big problem even if they did arise.
