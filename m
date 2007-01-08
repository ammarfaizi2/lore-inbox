Return-Path: <linux-kernel-owner+w=401wt.eu-S1161342AbXAHQVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161342AbXAHQVl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbXAHQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:21:40 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50278 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161344AbXAHQVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:21:40 -0500
Date: Mon, 8 Jan 2007 16:32:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extract duplicated constants out of PIIX like drivers
Message-ID: <20070108163229.364cbdc8@localhost.localdomain>
In-Reply-To: <45A26E74.2050509@pobox.com>
References: <20070108122313.73c08d2e@localhost.localdomain>
	<45A26E74.2050509@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jan 2007 11:16:52 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Alan wrote:
> > Each PIIX driver has two copies of a tiny 10 byte table. Jeff asked that
> > it was moved to a common place in each driver. Personally I think it
> > looked a lot better before but as Jeff is maintainer it's his call.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Did I really ask for this?  ;-)

You did and I can prove it as I have the email ;)

> Looking at the patch, I think prefer the unpatched code, and would 
> prefer to drop this patch if that's ok?

Definitely fine by me. Will flush from my tree

Alan
