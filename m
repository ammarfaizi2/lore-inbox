Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbTAJKLS>; Fri, 10 Jan 2003 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbTAJKLR>; Fri, 10 Jan 2003 05:11:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:44548 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264624AbTAJKLQ>;
	Fri, 10 Jan 2003 05:11:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301101019.h0AAJx5w003433@darkstar.example.net>
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
To: fverscheure@wanadoo.fr
Date: Fri, 10 Jan 2003 10:19:59 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030110095558.E144CFF11@postfix4-1.free.fr> from "Francis Verscheure" at Jan 10, 2003 10:54:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And by the way how are powered off the IDE drives ?
> Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before
> powering off the drive with cache enabled or you will enjoy lost
> data.

This was discussed on the list a few months ago:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103188486216124&w=2

I'm not sure it really got fully resolved, I had disks that would
spin down and then spin up again, because of the order that the
standby and flush cache commands were sent.

John
