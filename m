Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVF1U2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVF1U2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVF1UZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:25:31 -0400
Received: from mailfe08.tele2.fr ([212.247.154.236]:42941 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261404AbVF1UVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:21:05 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Tue, 28 Jun 2005 22:20:53 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Robert Love <rml@novell.com>, Andy Isaacson <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628202053.GO4645@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Robert Love <rml@novell.com>, Andy Isaacson <adi@hexapodia.org>,
	linux-kernel@vger.kernel.org
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr> <20050628200330.GB4453@wohnheim.fh-wedel.de> <1119989111.6745.21.camel@betsy> <20050628201704.GC4453@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628201704.GC4453@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel, le Tue 28 Jun 2005 22:17:04 +0200, a écrit :
> If the application knows 100% that it is the _only_ possible user of
> this data and will never again use it, dropping dirty pages might be a
> sane option.  Effectively that translates to anonymous memory only.

And private file mappings?

Regards,
Samue
