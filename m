Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbULaO6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbULaO6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbULaO6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:58:31 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:34950 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S262096AbULaO63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:58:29 -0500
Date: Thu, 14 Oct 2004 23:51:51 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041014215151.GA4237@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041005063324.GA7445@darjeeling.triplehelix.org> <20041009101552.GA3727@stusta.de> <20041009140551.58fce532.akpm@osdl.org> <20041011182518.GA1892@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011182518.GA1892@stusta.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:25:18PM +0200, Adrian Bunk wrote:
> > >  > darjeeling:~{1}% bg
> > >  > [1]  + continued  make
> > >  > make: *** wait: No child processes.  Stop.
> > >  > make: *** Waiting for unfinished jobs....
> >...
> > >  I'm also observing this problem.
> > offending patch?
> 
> The problem seems to be surprisingly old.

 I got bit by this error several times using slrn (news reader in s-lang).
If I press ^Z, slrn suspneds but spews error on 'fg'. Something about
IO error. It happened only om -mm kernels.
 I've saved strace output on -linus (where it worked), but beeing unable
to strace it on -mm [1] I deleted all logs and learned not to press ^Z.

[1] strace hung my system on -mm few times.

-- 
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox

