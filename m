Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWBYRPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWBYRPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBYRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:15:16 -0500
Received: from dze141s31.ae.poznan.pl.220.254.150.in-addr.arpa ([150.254.220.184]:34194
	"EHLO dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S932582AbWBYRPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:15:14 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.3 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-3.7/2.5):. Processed in 0.746177 secs Process 5836)
Date: Sat, 25 Feb 2006 18:15:21 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <612760535.20060225181521@dns.toxicfilms.tv>
To: Jesper Juhl <jesper.juhl@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: creating live virtual files by concatenation
In-Reply-To: <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
References: <1271316508.20060225153749@dns.toxicfilms.tv>
 <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper, Jan,

thanks for your replies. What I had in mind was not a solution
to any specific problem, but a filesystem feature.

A feature that could be used anywhere to have a live version
of files, a bit of what SQL CREATE VIEW could do for databases.

Code files, DNS zones, configuration files, HTML code. We are still
dealing with lots of text files today. Sometimes we do tiresome operations
on them or have to make up solutions similar to which Jesper had
proposed (using cat and updating it, using application level features,etc)

> Might be a cute little hack, but I don't think it's a very useful
> feature really..
Well, I will give FUSE a shot. However I have a hunch that this type
of feature is actually the future of something like filesystem services
for userspace.

Filesystems providing ways for userspace applications to create temporary
files, view, collections based on metadata. But that is completely
an other story, I wanted to keep low with ideas.

-- 
Best regards,
Maciej


