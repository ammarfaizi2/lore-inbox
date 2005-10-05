Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVJELE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVJELE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVJELE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:04:29 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:43952 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932604AbVJELE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:04:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=RFkCtpcKeL9Hi0fcz2+h5dcKD6Mqp+nesc43d06eQGQrdchkNYpRaWO5ttjM9ivLNmZ+95CFCSemBhjaOEVmWbvWHx2QVff2JVvdYcM0Ozn69b3ma0SaB18DMhjVzd73Uqbokgbw6XWuJMe4zW+uhdH5Igyq2wb0HToXvQ3srPs=
Date: Wed, 5 Oct 2005 13:04:10 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: chase.venters@clientec.com, marc@perkel.com, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-Id: <20051005130410.ddae71b3.diegocg@gmail.com>
In-Reply-To: <20051005102650.GO10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	<4342DC4D.8090908@perkel.com>
	<200510041840.55820.chase.venters@clientec.com>
	<20051005102650.GO10538@lkcl.net>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 5 Oct 2005 11:26:50 +0100,
Luke Kenneth Casson Leighton <lkcl@lkcl.net> escribió:

> > Now I certainly wouldn't advocate a Windows-style registry, 
> > because I think it's full of obvious problems. 
> 
>  such as? :)


The ugly implementation (inside the kernel and as a big file instead of doing it as a
userspace in top of NTFS files which would have helped them to avoid lots of problems
that they were forced to solve in XP/2003, it's clear from their docs that they didn't
expected that registry could grow _so_ much), the fact that they use it to store at
the same time userspace configuration and internal kernel structures. The "idea" is
nice but the way they've implemented and used it is horrible - just take a look
at how they're using XML configuration files for IIS now... (I've been said that ISS will
detect when you're editing those configuration files and will reload them to duplicate
the changes you just made in the registry ..... ugh)


>  hey, you know what?  if linux got a registry, it would be possible for
>  the kernel to access - and store, and communicate - persistent
>  information

right - why you would want to do such thing is another story
