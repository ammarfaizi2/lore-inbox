Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268739AbTBZN4C>; Wed, 26 Feb 2003 08:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268749AbTBZN4C>; Wed, 26 Feb 2003 08:56:02 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:24070 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268739AbTBZN4C>; Wed, 26 Feb 2003 08:56:02 -0500
Date: Wed, 26 Feb 2003 14:06:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ATM] suni_init declared __init AND exported?
Message-ID: <20030226140617.B5698@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	linux-kernel@vger.kernel.org
References: <200302261318.h1QDIE4x004103@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302261318.h1QDIE4x004103@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Wed, Feb 26, 2003 at 08:18:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 08:18:14AM -0500, chas williams wrote:
> modules.  however this seems to be a problem for 2.5 since
> suni_init will be discarded after the suni module is loaded.
> atm drivers calling suni_init() during their startup/load
> oops since the suni_init() function is no longer available.
> 
> the __init should go away right?

yes.

