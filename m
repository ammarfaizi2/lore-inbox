Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWDXQcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWDXQcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDXQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:32:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53707 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750966AbWDXQcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:32:12 -0400
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Al Boldi <a1426z@gawab.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200604241746.43005.a1426z@gawab.com>
References: <200511142327.18510.a1426z@gawab.com>
	 <200604241653.49647.a1426z@gawab.com> <1145887895.32427.5.camel@localhost>
	 <200604241746.43005.a1426z@gawab.com>
Date: Mon, 24 Apr 2006 19:32:09 +0300
Message-Id: <1145896330.11267.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 17:46 +0300, Al Boldi wrote:
> But -O3 creates faster code w/ some strange flaws like failing nfs-boot.
> Maybe that's fixed in the latest gcc, but gcc-3.2.2 was exhibiting this bug.
> So this doesn't really help a developer to be confident about compiler 
> optimization, thus taking the safe route for performance sensitive 
> code-paths.

Are you talking about a real GCC bug which you must work around? If not,
please don't obfuscate the code for no good reason.

				Pekka

