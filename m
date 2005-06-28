Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVF1Kaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVF1Kaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVF1Kaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 06:30:30 -0400
Received: from pppoe240-static-luxdsl-128.pt.lu ([213.135.240.128]:52171 "EHLO
	server.intern.prnet.org") by vger.kernel.org with ESMTP
	id S261172AbVF1Ka0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 06:30:26 -0400
Message-ID: <51163.212.24.212.169.1119954577.squirrel@212.24.212.169>
In-Reply-To: <20050627214016.2046e29e.akpm@osdl.org>
References: <42C0C9A3.9030404@prnet.org>
    <20050627214016.2046e29e.akpm@osdl.org>
Date: Tue, 28 Jun 2005 12:29:37 +0200 (CEST)
Subject: Re: linux 2.6.12 and IOWAIT
From: "David Arendt" <admin@prnet.org>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "David Arendt" <admin@prnet.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Arendt <admin@prnet.org> wrote:
>>
>> Hi,
>>
>> I have to following problem using kernel 2.6.12: IOWAIT is always at
>> 100% in top, the system seems to be significally slower. Any idea what
>> could lead to this ?
>
> Look for a process stuck in D state in the `ps aux' output.
>

The problem was spamassain, it was hanging while processing a mail
containing an aide report. After rebooting my machine, the mail was still
in queue and spamassasain started again. This happened at the same time I
upgraded to 2.6.12, therefore I thought it was due to it.
