Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWG3InY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWG3InY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWG3InY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:43:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751197AbWG3InY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:43:24 -0400
Subject: Re: Linux v2.6.18-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <06ATUBD12@briare1.heliogroup.fr>
References: <06ATUBD12@briare1.heliogroup.fr>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 10:43:21 +0200
Message-Id: <1154249002.2941.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 12:21 +0000, Hubert Tonneau wrote:
> > Linus Torvalds wrote:
> >
> > In fact, it's been pretty quiet since too, which I attribute to 2.6.18-rc2
> > just being so good
> 
> Not 'so good' but 'no boot'
> 
> Freeing unused kernel memory: 152 K
> Inconsistency detected by ld.so: rtld.c: 1192: ld_main:
> Assertion '(void *) ph->p_vaddr == _rtld_local_._dl_sysinfo_dso' failed !
> Kernel panic - not syncing: Attempted to kill init !
> 

interesting; this would implicate the vdso change.

Which distribution and glibc version are you using?


