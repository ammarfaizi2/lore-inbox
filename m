Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUJGTvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUJGTvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUJGTr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:47:56 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:37273 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S267866AbUJGS76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:59:58 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Jesse Barnes" <jbarnes@engr.sgi.com>, "Patrick Gefre" <pfg@sgi.com>,
       "Grant Grundler" <iod00d@hp.com>, "Colin Ngam" <cngam@sgi.com>,
       "Matthew Wilcox" <matthew@wil.cx>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F022669A9@scsmsx401.amr.corp.intel.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 07 Oct 2004 14:59:57 -0400
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F022669A9@scsmsx401.amr.corp.intel.com>
Message-ID: <yq04ql6tkuq.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Luck," == Luck, Tony <tony.luck@intel.com> writes:

>> Yeah, sorry, I shouldn't have said cleanup, fixup is better.
>> Anyway, they need to be separate since they'll be going into the
>> tree via Andrew not Tony.

Luck,> A couple of days back I said that I'm ok pushing these drivers.
Luck,> Although they don't have "arch/ia64" or "include/asm-ia64"
Luck,> prefixes, they are only used by ia64.  I'm even ok with the
Luck,> qla1280.c change as the final version is only touching code
Luck,> inside #ifdef CONFIG_IA64_{GENERIC|SN2) ... but I would like to
Luck,> see a sign-off from the de-facto maintainer Christoph for this
Luck,> file.

Tony,

As the maintainer for qla1280, I'll be happy sign off on the SN2
related changes. In fact it's a cleanup compared to the older hack I
implemented.

Cheers,
Jes
