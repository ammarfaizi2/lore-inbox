Return-Path: <linux-kernel-owner+w=401wt.eu-S932381AbXADKro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbXADKro (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 05:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXADKro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 05:47:44 -0500
Received: from pat.uio.no ([129.240.10.15]:40800 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbXADKrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 05:47:42 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <459CD11E.3000200@panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
	 <1167780097.6090.104.camel@lade.trondhjem.org>
	 <459BA30A.4020809@panasas.com>
	 <1167899796.6046.11.camel@lade.trondhjem.org>
	 <459CD11E.3000200@panasas.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 11:47:20 +0100
Message-Id: <1167907640.6046.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 6F4F28CF91F21AAF43A45623E5A8B64B6D088701
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 12:04 +0200, Benny Halevy wrote:
> I agree that the way the client implements its cache is out of the protocol
> scope. But how do you interpret "correct behavior" in section 4.2.1?
>  "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients need to be prepared for situations in which it cannot be determined whether two filehandles denote the same object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
> Don't you consider data corruption due to cache inconsistency an incorrect behavior?

Exactly where do you see us violating the close-to-open cache
consistency guarantees?

Trond

