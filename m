Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311439AbSCVJUd>; Fri, 22 Mar 2002 04:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311435AbSCVJUX>; Fri, 22 Mar 2002 04:20:23 -0500
Received: from mail.fh-wedel.de ([195.37.86.23]:61702 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id <S311434AbSCVJUP>;
	Fri, 22 Mar 2002 04:20:15 -0500
Date: Fri, 22 Mar 2002 10:20:06 +0100
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-cd-typo.patch (Re: Linux 2.4.19-pre3-ac5)
Message-ID: <20020322102006.B16964@wohnheim.fh-wedel.de>
In-Reply-To: <20020322095628.A28751@wohnheim.fh-wedel.de> <Pine.LNX.4.10.10203220109130.9319-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 March 2002 01:14:14 -0800, Andre Hedrick wrote:
> Goto Line 790 in ide-cd.c and manually edit it.
> 
> But since you asked for a patch here is one.
>
> [...]
>
> -	if (HWGROUP(drive)->handler == NULL)	/* paranoia check */
> +	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
>  		BUG();

Makes more sense. Thank you!

Jörn

-- 
Highly skilled employees are always promoted to a level of
incompetency. They get promoted for doing a good job, until they
don't.
-- unknown
