Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUGMLCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUGMLCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGMLCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:02:44 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:12961 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264819AbUGMLCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:02:43 -0400
Date: Tue, 13 Jul 2004 13:02:26 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jesus Delgado <jdelgado@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken driver via-rhine.c in kernel 2.6.8-rc1
Message-ID: <20040713110226.GB30087@k3.hellgate.ch>
Mail-Followup-To: Jesus Delgado <jdelgado@gmail.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
References: <57861437040712220518dee67d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57861437040712220518dee67d@mail.gmail.com>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004 00:05:10 -0500, Jesus Delgado wrote:
> The problems with driver via-rhine.c version v1.10-LK1.1.20-2.6
> May-23-2004:via-rhine: probe of 0000:00:12.0 failed with error -5
> Invalid MAC address for card #0
> 
> kernel 2.6.7 and kernel 2.6.7-mm7  working good via-rhine.c

I can't reproduce the bug on any of my hardware right now (it was there
once, it's gone now). But Jesper Juhl can and he's narrowing down what
makes the difference between those drivers.

Can you guys send me your .config? And btw, does using an old via-rhine
driver (say from vanilla 2.6.7) with 2.6.8-rc1 fix the problem?

Roger
