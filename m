Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290813AbSAYS6W>; Fri, 25 Jan 2002 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290794AbSAYSzv>; Fri, 25 Jan 2002 13:55:51 -0500
Received: from ns.caldera.de ([212.34.180.1]:59358 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290804AbSAYSyW>;
	Fri, 25 Jan 2002 13:54:22 -0500
Date: Fri, 25 Jan 2002 19:53:38 +0100
Message-Id: <200201251853.g0PIrcB28774@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: christophe.barbe.ml@online.fr (christophe barb? )
Cc: linux-kernel@vger.kernel.org, simon@baydel.com
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020125170642.GG671@online.fr>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020125170642.GG671@online.fr> you wrote:
> But IIRC these symbol were used only for the 2.2 kernel (that I assume
> you are using?) and the support for 2.2 kernel was removed in the
> opengfs fork.

No - OpenGFS 0.0.9x still needs them even on 2.4.
The next development series leading toward 0.2 will remove that
requirement by resturcturing all the code that currently uses
64bit arithmetics without any real need.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
