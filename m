Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWISGrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWISGrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWISGrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:47:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:14765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750701AbWISGrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:47:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: TCP stack behaviour question
Date: Tue, 19 Sep 2006 08:47:10 +0200
User-Agent: KMail/1.9.3
Cc: "Stuart MacDonald" <stuartm@connecttech.com>, linux-kernel@vger.kernel.org
References: <005501c6db44$102b73a0$294b82ce@stuartm> <20060919061335.113810@gmx.net>
In-Reply-To: <20060919061335.113810@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190847.10882.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 08:13, Michael Kerrisk wrote:
> Von: "Stuart MacDonald" <stuartm@connecttech.com>
> 
> > > > Ok maybe it's a bit misleading. Michael, you might want to clarify.
> > > 
> > > Can some one of you propose a better text please?
> > 
> > Perhaps
> > 
> > Note that TCP has no error queue; MSG_ERRQUEUE is illegal on
> > SOCK_STREAM sockets.  IP_RECVERR is valid for TCP, but all errors are
> > returned by socket function return or SO_ERROR only.
> > 
> > ?
> 
> Sound okay to you Andi?

Yes.
-Andi
