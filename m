Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSLJKMW>; Tue, 10 Dec 2002 05:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSLJKMW>; Tue, 10 Dec 2002 05:12:22 -0500
Received: from [81.2.122.30] ([81.2.122.30]:18692 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266749AbSLJKMU>;
	Tue, 10 Dec 2002 05:12:20 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212101031.gBAAVTjI000445@darkstar.example.net>
Subject: Re: Difference between dummy and loopback interfaces
To: ptb@it.uc3m.es (Peter T. Breuer)
Date: Tue, 10 Dec 2002 10:31:29 +0000 (GMT)
Cc: ahtraps@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200212090849.gB98n2319698@oboe.it.uc3m.es> from "Peter T. Breuer" at Dec 09, 2002 09:49:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can't think of a condition where a dummy device is useful (other than
> > for simulating a blackhole device which sucks every packet sent to it).
> 
> The dummy device is conventionally used to provide a separate interface
> that can be used to bind the hostname to when there is no real nic in
> the box to bind it to (binding it to loopback being a no no).

Slackware binds the hostname to 127.0.0.1 by default.  As pointed out
in comments in the /etc/hosts file, it is technically incorrect, but
it does work, and it's fine on a non-networked machine.

John.
