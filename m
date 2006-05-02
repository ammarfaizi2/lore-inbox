Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWEBNRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWEBNRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWEBNRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:17:38 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:43242 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S964804AbWEBNRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:17:37 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jiri Slaby <jirislaby@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
	<1146502730.2885.128.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.61.0605012219560.32033@yvahk01.tjqt.qr>
	<4456732B.2090009@gmail.com>
	<Pine.LNX.4.61.0605012300080.782@yvahk01.tjqt.qr>
	<1146517650.1921.55.camel@shinybook.infradead.org>
From: Jes Sorensen <jes@sgi.com>
Date: 02 May 2006 09:17:34 -0400
In-Reply-To: <1146517650.1921.55.camel@shinybook.infradead.org>
Message-ID: <yq0d5ewr2fl.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

David> On Mon, 2006-05-01 at 23:01 +0200, Jan Engelhardt wrote:
>> find rc3 -type f -print0 | xargs -0 perl -i -pe
>> 's/\btask_t\b/struct task_struct'
>> 
>> + a compile test afterwards. Something I missed? (Besides that
>> lines may get longer and violate the 80-column CodingStyle rule.)

David> If we're going to do that, we might as well make it 'struct
David> task'. The additional '_struct' is redundant.

There were some long discussions about that a couple of years ago. I
believe Linus stated that he preferred _struct for those things.

It is also less likely to hit name clashes.

Jes
