Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWFRWsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWFRWsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFRWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:48:31 -0400
Received: from mailfe12.tele2.fr ([212.247.155.108]:48264 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750941AbWFRWsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:48:31 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Mon, 19 Jun 2006 00:48:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618224828.GF4744@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618223906.GA30726@animx.eu.org> <20060618224051.GE4744@bouh.residence.ens-lyon.fr> <20060618224424.GH13255@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618224424.GH13255@w.ods.org>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau, le Mon 19 Jun 2006 00:44:24 +0200, a écrit :
> On Mon, Jun 19, 2006 at 12:40:51AM +0200, Samuel Thibault wrote:
> > Wakko Warner, le Sun 18 Jun 2006 18:39:06 -0400, a écrit :
> > > why not only set this if the shell is /bin/sh ?
> > 
> > Because you can't know that. /bin/sh is one example of shell, /bin/ash
> > is another /usr/bin/myprog is yet another...
> 
> another possibility would be to do it only if 'init=' has been specified,
> since most of the time the kernel finds it itself.

Init needs to be patched for the emergency case then.

Samuel
