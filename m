Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUHFNJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUHFNJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUHFNJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:09:52 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:19627 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S268128AbUHFNJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:09:51 -0400
Date: Fri, 6 Aug 2004 15:09:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: qeth performance.
Message-ID: <20040806130942.GB2065@wohnheim.fh-wedel.de>
References: <20040806124941.GA2065@wohnheim.fh-wedel.de> <OFECABF5A6.F2037B97-ON42256EE8.00472EEA-42256EE8.0047790E@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFECABF5A6.F2037B97-ON42256EE8.00472EEA-42256EE8.0047790E@de.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 August 2004 15:00:40 +0200, Martin Schwidefsky wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 06/08/2004 02:49:41 PM:
> >
> > After 50% of the patch I grew tired of it.  Martin, since when do you
> > like excessive use of #ifdef?
> 
> Well, it isn't so bad. Only 35 #ifdef CONFIG_QDIO_DEBUG.

Maybe our definitions of "isn't so bad" don't match. ;)
Anyway, it's a first step.  No new code was added, the old debugging
mess is explicitly marked as such now.  Next step would be to either
completely get rid of it or replace it with something less ugly.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
