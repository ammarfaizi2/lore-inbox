Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130483AbQLRVJX>; Mon, 18 Dec 2000 16:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLRVJO>; Mon, 18 Dec 2000 16:09:14 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:35084 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129436AbQLRVJH>; Mon, 18 Dec 2000 16:09:07 -0500
Date: Mon, 18 Dec 2000 21:38:01 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David Schwartz <davids@webmaster.com>
Cc: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-ID: <20001218213801.A19903@pcep-jamie.cern.ch>
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz> <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>; from davids@webmaster.com on Sun, Dec 17, 2000 at 04:18:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> The code does its best to estimate how much actual entropy it is gathering.

A potential weakness.  The entropy estimator can be manipulated by
feeding data which looks random to the estimator, but which is in fact
not random at all.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
