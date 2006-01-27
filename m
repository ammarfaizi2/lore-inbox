Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWA0UNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWA0UNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWA0UNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:13:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030329AbWA0UNo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:13:44 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060127071806.GA4082@hardeman.nu> 
References: <20060127071806.GA4082@hardeman.nu>  <1138312694656@2gen.com> <E1F2I7q-0007F6-00@gondolin.me.apana.org.au> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 27 Jan 2006 20:11:25 +0000
Message-ID: <6497.1138392685@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> I have no problems with moving it to lib/mpi unless someone feels its a bad
> idea (DHowells, do you agree?).

I don't think that's the right place for it, except for the fact you can then
use the archive library generated to only include as much of mpilib as you
actually require. It seems to me that it should really belong with the crypto
stuff.

David
