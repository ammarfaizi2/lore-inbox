Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVFUT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVFUT0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVFUT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:26:30 -0400
Received: from CPE00095b3131a0-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.28.191.58]:4225
	"EHLO kenichi") by vger.kernel.org with ESMTP id S262254AbVFUT0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:26:12 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: Edward Shishkin <edward@namesys.com>
Subject: Re: [PATCH] Fix Reiser4 Dependencies
Date: Tue, 21 Jun 2005 15:26:03 -0400
User-Agent: KMail/1.7.2
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B7F98B.5050405@namesys.com> <42B860D9.60109@namesys.com>
In-Reply-To: <42B860D9.60109@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211526.03750.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Edward, Hans.

> Edward Shishkin wrote:
> > ZLIB_INFLATE/DEFLATE  will be selected by special reiser4 related
> > configuration
> > option "Enable reiser4 compression plugins of gzip family" ...
Sounds promising.

> > Anyway thanks,
You're welcome.

On June 21, 2005 02:47 pm, Hans Reiser wrote:
> I am sorry, are you telling him that it works for you because you have
> code that is different?
As I understand it, when his upcoming changes are merged, base Reiser4
would no longer depend on ZLIB_INFLATE/DEFLATE and my patch would then be
incorrect. I am not in a position to know whether a code-dump or a minimal
fix or something in-between is most appropriate for the next -mm release,
for the moment just tweaking the Kconfig is working for me (I'm using
Reiser4 under 2.6.12-mm1 with no further problems).

HTH,
Andrew
