Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTLQRuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLQRuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:50:51 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:62421 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S264502AbTLQRut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:50:49 -0500
Date: Wed, 17 Dec 2003 18:50:37 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4-bk] build error in page_alloc.c
Message-ID: <20031217175037.GB8593@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031217174325.GA8593@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20031217174325.GA8593@neon>
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel!

On Wed, 17 Dec 2003, Axel Siebenwirth wrote:

> Just tried to build 2.4 from current bk.
> config.gz is attached.
> 
> gcc -D__KERNEL__ -I/usr/local/src/system/kernel/linus-2.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=pentium4   -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=page_alloc  -DEXPORT_SYMTAB -c page_alloc.c
> page_alloc.c: In function _alloc_pages':
> page_alloc.c:382: error: parse error before '{' token
> page_alloc.c:339: warning: unused variable reed'

Sorry. Missing closing brace. Didn't check the list before I wrote my
report.

Regards,
Axel
