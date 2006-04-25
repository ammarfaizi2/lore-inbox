Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWDYIwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDYIwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDYIwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:52:49 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:62856 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932136AbWDYIws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:52:48 -0400
Date: Tue, 25 Apr 2006 10:52:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Michael Holzheu <holzheu@de.ibm.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Message-ID: <20060425085230.GA23127@wohnheim.fh-wedel.de>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com> <1145948304.11463.5.camel@localhost> <1145950336.11463.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1145950336.11463.8.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 April 2006 10:32:16 +0300, Pekka Enberg wrote:
> 
> Hmm, thinking about this, I think a better API would be to not have that
> reject parameter at all. Would something like this be accetable for your
> use?

[...]

> +	while (*s && isspace(*s))
> +		s++;

Just checking.  This does remove a newline, right?

J�rn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
