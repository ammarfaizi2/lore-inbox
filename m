Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUBOSCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBOSCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:02:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:34820 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265136AbUBOSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:02:33 -0500
Date: Sun, 15 Feb 2004 18:02:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Message-ID: <20040215180226.A8426@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
	linux-kernel@vger.kernel.org
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1076866470.20140.13.camel@leto.cs.pocnet.net>; from christophe@saout.de on Sun, Feb 15, 2004 at 06:34:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 06:34:31PM +0100, Christophe Saout wrote:
> could you try dm-crypt? It uses the device-mapper instead of the loop
> device but should be compatible (uses cryptoapi too). It's going to be
> added to the kernel soon I hope.

What's holding it back?  I'd rather get rid of all the cryptoloop crap
sooner or later.

