Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756802AbWKSRVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbWKSRVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbWKSRVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:21:04 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:65073 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1756802AbWKSRVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:21:02 -0500
Date: Sun, 19 Nov 2006 18:20:47 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
Message-ID: <20061119172047.GA7376@aepfle.de>
References: <20061119120000.GA4926@aepfle.de> <aday7q7jrds.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aday7q7jrds.fsf@cisco.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, Roland Dreier wrote:

> looks weird to me.  AFAIK the C standard says that offsetof() comes
> from plain old <stddef.h>.  Does the (untested) patch below fix the
> build for you?

Yes, it does.
