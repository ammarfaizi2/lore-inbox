Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUCOSm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUCOSm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:42:58 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:43626 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262597AbUCOSm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:42:56 -0500
Date: Mon, 15 Mar 2004 19:43:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1 and -mm2: include/linux/version.h missing (vanilla ok)
Message-ID: <20040315184332.GA14464@mars.ravnborg.org>
Mail-Followup-To: Fabian Fenaut <fabian.fenaut@free.fr>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org> <20040315174148.GA2163@mars.ravnborg.org> <4055F027.2070906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4055F027.2070906@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 07:04:23PM +0100, Fabian Fenaut wrote:
> 
> And, to compile my modules successfully, I copied version.h from vanilla
> to /usr/src/2.6.4-mm2/include/linux (and modified it the correct way).
> Then I compiled my modules, and after that, my hand-made version.h is
> still here, so make-kpkg doesn't delete anything.
> 
> => version.h is _never_ created.

Works for me - hmmm.
1) Could you check you have write access to include/linux
2) Show the output of a make (please, no magic debian shell scripts)
3) Set CLEAN_FILES equal nothing in top-level Makefile
   and try again.

Please mail the result of the above.

	Sam
