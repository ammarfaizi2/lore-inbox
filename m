Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTIVEn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTIVEn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:43:56 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:56811 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262774AbTIVEnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:43:55 -0400
Date: Mon, 22 Sep 2003 06:43:54 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Robert Love <rml@tech9.net>
Cc: Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE]  slab information utility
Message-ID: <20030922044354.GA18855@DUK2.13thfloor.at>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
References: <1064199786.1199.29.camel@boobies.awol.org> <20030922042308.GA8691@DUK2.13thfloor.at> <1064205590.8888.207.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064205590.8888.207.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robert!

On Mon, Sep 22, 2003 at 12:39:50AM -0400, Robert Love wrote:
> On Mon, 2003-09-22 at 00:23, Herbert Poetzl wrote:
> 
> > dm io                  0      0     36    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
> 
> It is this bastard.  No easy way to parse text files when fields have
> the delimiter in them, unfortunately.
> 
> Not too sure what to do but patch the kernel not to have spaces in slab
> cache names.  I know I have seen such patches go in before.

what about checking at which position the space occurs?

at least to me it seems like pos < 20 would be okay
for a space in the name  8-)

best,
Herbert

> 	Robert Love
> 
