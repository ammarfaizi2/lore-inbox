Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTKRNoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTKRNm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:59 -0500
Received: from ns.suse.de ([195.135.220.2]:8146 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262766AbTKRNmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:22 -0500
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [i386] Remove bogus panic calls in mpparse.c
References: <20031113095721.GB27003@gondor.apana.org.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2003 12:03:08 +0100
In-Reply-To: <20031113095721.GB27003@gondor.apana.org.au.suse.lists.linux.kernel>
Message-ID: <p738ymksf83.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> 2. The user won't see it since the console hasn't initialised yet.

It just means we should really support early_console on i386 too.

I believe Martin Bligh has a patch in his -mjb patchkit. I still believe
it would be very useful in mainline.

-Andi 
