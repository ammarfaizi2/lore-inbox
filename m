Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVE0Oqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVE0Oqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVE0Oqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:46:51 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44997 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261774AbVE0Oqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:46:42 -0400
Message-ID: <429732CE.5010708@gmx.de>
Date: Fri, 27 May 2005 16:46:38 +0200
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de>
In-Reply-To: <20050527135258.GW1435@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> NCQ requires hardware support from both the controller and hard drive,
> you can view Jeff's libata status page for which controllers support
> NCQ.

So that means controllers that do not support either NCQ or HBQ just
suck and should not be cared about, and if I were to go into SATA, I
should just get a new controller and forget about my onboard VIA crap.
(I read newer VIA are supposed to support AHCI which is good.)

-- 
Matthias Andree
