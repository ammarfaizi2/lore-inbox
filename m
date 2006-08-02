Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWHBDLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWHBDLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHBDKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:10:42 -0400
Received: from ns.suse.de ([195.135.220.2]:5609 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751097AbWHBDKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:10:39 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
Date: Wed, 2 Aug 2006 05:07:50 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <p73zmeoz2l4.fsf@verdi.suse.de> <m1r6zzx41y.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r6zzx41y.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020507.50590.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Actually the best way to reuse would be to first do 64bit uncompressor
> > and linker directly, but short of that #includes would be fine too.
> 
> > Would be better to just pull in lib/string.c
> 
> Maybe.  Size is fairly important 

Why is size important here?

-Andi
