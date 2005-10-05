Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVJEOfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVJEOfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVJEOfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:35:04 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:10252 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932632AbVJEOfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:35:03 -0400
To: 7eggert@gmx.de
Cc: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz>
From: Nix <nix@esperi.org.uk>
X-Emacs: a real time environment for simulating molasses-based life forms.
Date: Wed, 05 Oct 2005 15:34:53 +0100
In-Reply-To: <E1EMutG-0001Hd-7U@be1.lrz> (Bodo Eggert's message of "4 Oct
 2005 23:04:46 +0100")
Message-ID: <87k6gsjalu.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Oct 2005, Bodo Eggert stated:
> BTW: YANI: That about a tmpfs where all-numerical entries can only be
> created by the corresponding UID? This would provide a secure, private
> tmp directory to each user without the possibility of races and denial-of-
> service attacks. Maybe it should be controlled by a mount flag.

Wouldn't it be less kludgy to just use the existing private namespace
stuff to provide each user with its own /tmp? (Or each user's session,
rather, which is probably much easier, as that corresponds precisely to
one process tree).

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
