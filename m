Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUATSKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUATSKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:10:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21768 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265635AbUATSJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:09:40 -0500
Date: Tue, 20 Jan 2004 18:08:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
Message-ID: <20040120180851.A18872@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400D6A5B.7090009@sgi.com>; from pfg@sgi.com on Tue, Jan 20, 2004 at 11:50:19AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 11:50:19AM -0600, Patrick Gefre wrote:
> Yes this probably looks a little odd. This was setup this way for TIO. 
> The macro in the TIO code checks to see
> if it is a 'soft' struct or bridge address AND what bridge type it is - 
> accessing different registers depending
> on TIO or not TIO (the 2 cases we have so far). We think this makes the 
> register access functions pretty flexible/generic.

Sorry, but this is completly bogus.  Just declare one accessor per
datatype.

