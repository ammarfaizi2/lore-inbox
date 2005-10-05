Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVJEUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVJEUbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVJEUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:31:20 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45327 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030376AbVJEUbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:31:19 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	<4343E611.1000901@perkel.com>
	<20051005144441.GC8011@csclub.uwaterloo.ca>
	<4343E7AC.6000607@perkel.com>
	<20051005145606.GA7949@csclub.uwaterloo.ca>
	<4343EC6A.70603@perkel.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: featuring the world's first municipal garbage collector!
Date: Wed, 05 Oct 2005 21:31:05 +0100
In-Reply-To: <4343EC6A.70603@perkel.com> (Marc Perkel's message of "Wed, 05
 Oct 2005 08:08:26 -0700")
Message-ID: <87oe63ogdy.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2005, Marc Perkel announced authoritatively:
> If the permissions were don'e right in your own directories your
> inherited rights would give your permissions automatically to your
> home directory and all directories uner it. Netware has a concept
> called an inherited rights mask - something Linux lacks. Windows also
> has rights like this and Samba emulates it. So unless root put files
> in your directory and specifically denied you rights to them, you
> would have full rights to your own directory.

I quite forgot the most grotesque problem with this, which in my opinion
completely eliminates the possibility of inherited permissions on any
even vaguely-POSIX-like system.

What happens if you have a file with two links in directories with
different inheritable permissions set? What are its permissions now?
Surely it doesn't depend on where you happened to open it from!

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
