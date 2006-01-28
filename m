Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422827AbWA1Dpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbWA1Dpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWA1Dpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:45:46 -0500
Received: from pat.uio.no ([129.240.130.16]:44197 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422819AbWA1Dpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:45:45 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <8155F461-1703-476B-8C5D-B834EE49905D@mac.com>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com>
	 <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu>
	 <1138400385.8770.21.camel@lade.trondhjem.org>
	 <8155F461-1703-476B-8C5D-B834EE49905D@mac.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 22:45:25 -0500
Message-Id: <1138419925.8770.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.056, required 12,
	autolearn=disabled, AWL 1.76, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 18:35 -0500, Kyle Moffett wrote:

> No, the point is not to put the backup daemon into the kernel, but to  
> provide a way for the backup daemon and my user process to  
> communicate DSA key details without completely giving the backup  
> daemon my key.  I may not entirely trust the backup daemon not to get  
> compromised, but with support for the kernel keyring system,  
> compromising the backup daemon would only compromise the backed up  
> files, not the private keys and other secure data.

This sort of thing is implemented routinely in user space by means of
proxy tickets/certificates/credentials. What makes them insufficient for
this use?

Cheers,
  Trond

