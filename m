Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTKMIx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTKMIx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 03:53:29 -0500
Received: from mail.advantest.de ([213.61.178.178]:20489 "EHLO it.advantest.de")
	by vger.kernel.org with ESMTP id S262126AbTKMIx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 03:53:28 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
	<3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random>
From: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>
Organization: Jaluna
Date: 12 Nov 2003 22:35:22 +0100
In-Reply-To: <20031111150417.GF1649@x30.random>
Message-Id: <03Nov13.095622cet.122129@mojo.it.advantest.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> the usual problem, and the reason we need a sequence number (increased
> before and after the repo update). A file lock not.

Or a file that contains md5sums of the other files in the tree. 
After the rsync, you recompute the md5sums file, and if it does not match,
rsync again. As a bonus feature, the md5sums file can be pgp-signed.

  -- Benoit
