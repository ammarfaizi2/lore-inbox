Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267485AbUHPJGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267485AbUHPJGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHPJGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:06:31 -0400
Received: from ozlabs.org ([203.10.76.45]:34011 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267485AbUHPJG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:06:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.30991.27709.349218@cargo.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 19:06:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
In-Reply-To: <1092642051.959.56.camel@localhost>
References: <200408160254.i7G2ss3S000656@harpo.it.uu.se>
	<1092642051.959.56.camel@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox writes:

> Pages should be marked coherent for the MPC106 as well as the MPC107,

The MPC106 has an internal cache?  I had a quick look in the 106 and
107 manuals and I couldn't see in either one where it talks about a
cache.  Do you know where I should be looking?

Paul.
