Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVJEPzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVJEPzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVJEPzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:55:20 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:20636 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030194AbVJEPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:55:19 -0400
Date: Wed, 5 Oct 2005 11:55:16 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Marc Perkel <marc@perkel.com>, Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005155516.GF7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005152447.GD10538@lkcl.net> <20051005153006.GD8011@csclub.uwaterloo.ca> <20051005154226.GI10538@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005154226.GI10538@lkcl.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 04:42:26PM +0100, Luke Kenneth Casson Leighton wrote:
>  i have no idea.  as a user, i just did rm -fr /tmp/* (sorry - not
>  rm -fr /tmp) and it worked.
> 
>  as a user.
> 
>  not root.

Then some admin didn't qualify for root having apparently removed the t
bit from /tmp making it a world writeable dir.  Ouch.

>  they weren't dumb enough to give it to me.

But they made /tmp world writeable it seems.  Impresive. :)

>  ahh, that would answer the implicit question as to why they
>  jumped up and down at me rather than frog-marched me off campus.

Yep.  What you did should have been prevented by the system.  So the
system was misconfigured.

>  i was a student there.  they didn't let _anyone_ like me have root.
>  
>  someone got into trouble for even demonstrating a security
>  vulnerability.

Well this one sounds more liek a major misconfiguration than a security
problem.  Well allowing people to mess with temp could be seen as a
security problem but only until the permissions were fixed back to what
they would have originally been when the system was installed.

Len Sorensen
