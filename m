Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTELMAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTELMAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:00:38 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:63757 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262106AbTELMAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:00:37 -0400
Date: Mon, 12 May 2003 13:13:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: MPPE in kernel?
Message-ID: <20030512131319.A27217@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frank Cusack <fcusack@fcusack.com>, linux-kernel@vger.kernel.org,
	paulus@samba.org
References: <20030512045929.C29781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512045929.C29781@google.com>; from fcusack@fcusack.com on Mon, May 12, 2003 at 04:59:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 04:59:29AM -0700, Frank Cusack wrote:
> I really want is for the changes to ppp_generic.c to be included.
> It's not so much fun to have to maintain patches.  The changes required
> are generic, don't require crypto, and are generally uneventful.  Getting
> the crypto bits and the mppe compressor itself included would just be
> a bonus.

What about posting those changes for review?  If they are clean and your
arcfour implementation firts into the crypto API I guess it could go
into 2.5.  For 2.4.22 it sounds okay too if the 2.5ish crypto API goes
in as Davem mentioned.

