Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272166AbTHRRwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272169AbTHRRwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:52:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8065 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S272166AbTHRRwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:52:04 -0400
Date: Mon, 18 Aug 2003 18:51:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818175120.GD8044@mail.jlokier.co.uk>
References: <20030818115954.GA7147@mail.jlokier.co.uk> <Pine.LNX.4.44.0308180956350.21012-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308180956350.21012-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> if you care about global uniqueness then you add in config values that the
> sysasmin sets to make it unique (could be MAC address, IP address, machine
> name, GPS coordinates, etc)

Even a good sysadmin cannot guarantee the MAC address is unique, IP
addresses are often duplicates (e.g. 192.168.1.x) unless you know they
aren't), and the machine name is likely to conflict with someone
else's in the world, but these are all good inputs to include.

> the only reason to add in a random value is if you are trying to protect
> yourself from a malicious sysadmin and there are security problems that
> will arise for other machines if a sysadmin can duplicate this ID.

Not just malicious sysadmins, but accidental conflicts due to
e.g. trusting your MAC address to be unique in the world, too.

-- Jamie
