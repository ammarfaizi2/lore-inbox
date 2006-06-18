Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWFRWrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWFRWrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFRWrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:47:11 -0400
Received: from 1wt.eu ([62.212.114.60]:57352 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751046AbWFRWrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:47:09 -0400
Date: Mon, 19 Jun 2006 00:44:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618224424.GH13255@w.ods.org>
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618223906.GA30726@animx.eu.org> <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:40:51AM +0200, Samuel Thibault wrote:
> Wakko Warner, le Sun 18 Jun 2006 18:39:06 -0400, a écrit :
> > why not only set this if the shell is /bin/sh ?
> 
> Because you can't know that. /bin/sh is one example of shell, /bin/ash
> is another /usr/bin/myprog is yet another...

another possibility would be to do it only if 'init=' has been specified,
since most of the time the kernel finds it itself.

> Samuel

Regards,
willy

