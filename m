Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVDNUOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVDNUOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNUOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:14:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57264 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261489AbVDNUOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:14:17 -0400
Date: Thu, 14 Apr 2005 22:13:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414201357.GA2801@elf.ucw.cz>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414171127.GL3174@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Arguably, using dm-crypt is more secure, but it is also more
> > complicated from the Joe User POV. IMHO we should not force users to
> > set up dm-crypt, remember passwords etc., to get some basic
> > security.
> 
> Any sensible solution here is going to require remembering passwords.

Andreas has sensible good enough for preventing leaks from mlocked
data, and surprise, it does not need remembering anything.
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
