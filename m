Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135970AbRA1H2Q>; Sun, 28 Jan 2001 02:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136544AbRA1H2G>; Sun, 28 Jan 2001 02:28:06 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:22225 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135970AbRA1H14>;
	Sun, 28 Jan 2001 02:27:56 -0500
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: David Ford <david@linux.com>, devfs@oss.sgi.com, rgooch@atnf.csiro.au,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <3A7383B2.19DDD006@linux.com> <3A73C1D8.578AEEE@wanadoo.fr>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 27 Jan 2001 23:27:56 -0800
In-Reply-To: Pierre Rousselet's message of "Sun, 28 Jan 2001 07:53:12 +0100"
Message-ID: <m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:

> for me :
> make CFLAGS='-O2 -I. -D_GNU_SOURCE' 
> compiles without any patch. is it correct ?

Yes.  RTLD_NEXT is not in any standard, it's an extension available
via -D_GNU_SOURCE.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
