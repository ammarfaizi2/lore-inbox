Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUEZJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUEZJaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUEZJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:30:24 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:37280 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265377AbUEZJaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:30:19 -0400
Date: Wed, 26 May 2004 11:30:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: John Bradford <john@grabjohn.com>
Cc: Anthony DiSante <orders@nodivisions.com>, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526093007.GA4324@k3.hellgate.ch>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Anthony DiSante <orders@nodivisions.com>,
	linux-kernel@vger.kernel.org
References: <40B43B5F.8070208@nodivisions.com> <20040526082712.GA32326@k3.hellgate.ch> <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 10:23:32 +0100, John Bradford wrote:
> A run-away process on a server with too much swap can cause it to grind to
> almost a complete halt, and become almost compltely unresponsive to remote
> connections.
> 
> If the total amount of storage is just enough for the tasks the server is
> expected to deal with, then a run-away process will likely be terminated
> quickly stopping it from causing the machine to grind to a halt.

I'm not sure your optimism about the correct (run-away) process being
terminated is justified. Granted, there are definitely scenarios
where swapless operation is preferable, but in most circumstances --
especially workstations as the original poster described -- I'd rather
minimize the risk of losing data.

Roger
