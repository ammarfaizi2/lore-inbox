Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWC0DMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWC0DMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 22:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWC0DMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 22:12:23 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:49068 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751573AbWC0DMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 22:12:23 -0500
Date: Sun, 26 Mar 2006 22:12:27 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Message-ID: <20060327031227.GA5874@ccure.user-mode-linux.org>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 07:40:14PM -0500, Kyle Moffett wrote:
> According to Jeff Dike, UML would like access to some of that stuff  
> unrestricted by __KERNEL__ too.  

Not quite true - I just want them physically separated from the
non-userspace-usable stuff, as in different files.  I don't care
whether they are inside #ifdef __KERNEL__, because that's defined in
the UML build.

				Jeff
