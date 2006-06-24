Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWFXRga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWFXRga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWFXRga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:36:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63508 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750974AbWFXRg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:36:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FmajLerJf+ujTk6LDKLnuVGy038tgstBAhT6TkS65Kt1c1btCM34rulf7sZAljFSrEBir1BX17h6HZRTkN5LDAI9+l7y++HuMNF5MEJxXwgLOaGfH2M2KOcG4g6H+T20CT7HyNQ1Ltw14hXjH58q4POav7v2M4T7z9Ur6RzvC6Y=
Date: Sat, 24 Jun 2006 21:36:58 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Donald Parsons <dparsons@brightdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-...: looong writeouts
Message-ID: <20060624173658.GB7565@martell.zuzino.mipt.ru>
References: <1151166629.4409.18.camel@danny.parsons.org> <1151167852.3181.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151167852.3181.65.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:50:52PM +0200, Arjan van de Ven wrote:
> just a random question to rule things out: can you check if laptop mode
> is enabled? (see the /proc/sys/vm/laptop_mode file). Laptop mode will
> have the effect of grouping writes together, so if that got enabled
> accidentally for some reason, that could explain the behavior you are
> seeing. (and it would narrow down the "what broke" search problem to
> something that is a lot easier to work on)

Mine is not laptop and I've never enabled it.

