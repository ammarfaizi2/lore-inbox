Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUAUA0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUAUA0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:26:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:23564 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265901AbUAUA0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:26:43 -0500
Date: Wed, 21 Jan 2004 00:26:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
Message-ID: <20040121002635.A24123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com> <20040120180851.A18872@infradead.org> <400D8BBF.7070005@sgi.com> <20040120202132.A20668@infradead.org> <400DAA76.2080103@sgi.com> <20040120233417.A23173@infradead.org> <400DC67C.30705@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400DC67C.30705@sgi.com>; from pfg@sgi.com on Tue, Jan 20, 2004 at 06:23:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 06:23:24PM -0600, Patrick Gefre wrote:
> So something like this will work for you ???

Yes.  Although I'd really like to see a rationale why you need the version
operating on the I/O addresses at all.  The only thing I could up with is
that someone is too lazy to update a bunch of function prototypes. 

