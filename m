Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFDBzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 21:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFDBzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 21:55:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57002 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262578AbTFDBzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 21:55:35 -0400
Message-ID: <3EDD52F5.8090706@us.ibm.com>
Date: Tue, 03 Jun 2003 19:01:25 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: James Morris <jmorris@intercode.com.au>, davidm@hpl.hp.com,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, davem@redhat.com,
       akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
References: <200306040043.EAA24505@dub.inr.ac.ru>
In-Reply-To: <200306040043.EAA24505@dub.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:

> No doubts. All the symptoms are explained by this. I hope Andrew
> will confirm that the problem has gone.

Yep, great catch! But, FYI, DaveM and Alexey, we tried
reproducing the stalls we (Dave Hansen, Troy Wilson) had
seen during SpecWeb99 runs and couldn't reproduce them on
2.5.69. (Same config, etc). So its possible our hang/stalls
were some other issue that got silently fixed (or more
likely, possibly the same thing but other changes minimized
us running into the problem).

thanks,
Nivedita

