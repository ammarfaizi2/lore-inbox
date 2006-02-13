Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWBMQj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWBMQj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWBMQjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:39:25 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:17561 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932148AbWBMQjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:39:23 -0500
Message-ID: <43F0B62B.9080002@namesys.com>
Date: Mon, 13 Feb 2006 08:39:07 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Bernd Schubert <bernd-schubert@gmx.de>,
       Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
References: <200602080212.27896.bernd-schubert@gmx.de>	<200602081314.59639.bernd-schubert@gmx.de>	<20060208205033.GB22771@shell0.pdx.osdl.net>	<200602082246.15613.bernd-schubert@gmx.de>	<20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru> <43F01D70.70600@namesys.com> <43F0A4BA.20401@suse.com>
In-Reply-To: <43F0A4BA.20401@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, thanks for the patches Jeff, apologies for misreading it.

Hans

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
> >This is an xattr bug, and I'll let jeff answer it.
>
>
> Hans -
>
> This bug is about inode attributes (the chattr type), not extended
> attributes (the setfacl/setfattr type). Regardless, it's the root cause
> of the random attributes we were seeing when the REISERFS_ATTRS
> enable-by-default problem was corrected. Thanks to some other people on
> the list, I was able to post some patches to address it yesterday evening.
>
> -Jeff
>
> --
> Jeff Mahoney
> SUSE Labs

