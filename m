Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUBPGnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUBPGnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:43:35 -0500
Received: from netti-3-269.dyn.nic.fi ([212.38.238.14]:24804 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265371AbUBPGne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:43:34 -0500
From: Jan Knutar <jk-lkml@sci.fi>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Date: Mon, 16 Feb 2004 05:45:04 +0200
User-Agent: KMail/1.5
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
In-Reply-To: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402160545.04175.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - what happens to already existing invalid UTF-8 filenames ? Should
> the kernel forcibly rewrite them (in 2.7.0...) to remove legacy mess
> ? What should happen if someone plug an unconverted FS in such a
> system afterwards ?

What I would like would be a userspace tool, that would recurse and 
convert filename encodings from specified locale to UTF-8. Something 
like "any2utf8 -from iso8859-1 -recurse /mnt/myoldmp3disk". 
Does anyone know if such a tool exists already?

