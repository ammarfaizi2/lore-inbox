Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVASRXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVASRXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVASRWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:22:06 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:36578 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261790AbVASRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:15:24 -0500
Date: Wed, 19 Jan 2005 18:15:15 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: linux-os <linux-os@analogic.com>
Cc: Bodo Eggert <7eggert@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050119171515.GA31265@speedy.student.utwente.nl>
Mail-Followup-To: linux-os <linux-os@analogic.com>,
	Bodo Eggert <7eggert@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
References: <fa.e2phu9o.1c30pig@ifi.uio.no> <fa.gakt9b5.1klcr9h@ifi.uio.no> <E1CrIPb-0000lS-Oz@be1.7eggert.dyndns.org> <Pine.LNX.4.61.0501191128090.10869@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501191128090.10869@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 11:35:55AM -0500, linux-os wrote:
> >Sam Ravnborg <sam@ravnborg.org> wrote:
> >>1) Unconditionally execute make install assuming vmlinux is up-to-date.
> >>   make modules_install run unconditionally, so this is already know
> >>   practice
> 
> You must never execute `make install` or `make modules_install` without
> the explicit action of the operator! To do so could (will) result
> in an un-bootable system. I can't imagine what somebody would be
> thinking to propose an automatic install. Whoever proposed this
> must have lots of time and little knowledge. They are going to
> be reinstalling everything from the distribution CD as a hobby.

What I think Sam meant was, to let make install assume that vmlinux is
up-to-date, IOW, just to remove the dependency of install on vmlinux.

Err, to put it in your words: I can't imagine what somebody would be thinking
to think he proposed an automatic install. :-P

	Sytse
