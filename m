Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVFWTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVFWTXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVFWTPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:15:45 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:43197 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262705AbVFWTNa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:13:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P9hgkZGedztzTsgNDKV3f1hlOMJm5W2r0PHbW/Ph0iv2OXQ47CLbPOWUAWOprCOR/Pt86ixOHGZkJ5hl8Yvf1492i8OKSe0x02vNl8VAYwztQ9xQP1HMyM6mTPrZhblwcBMvtPHJ/td7up04HeFNA/+TsPbW+oaAGjB9cEjvHgo=
Message-ID: <9a87484905062312131e5f6b05@mail.gmail.com>
Date: Thu, 23 Jun 2005 21:13:29 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Script to help users to report a BUG
Cc: piotrowskim@trex.wsi.edu.pl, linux-kernel@vger.kernel.org
In-Reply-To: <20050623120647.2a5783d1.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	 <20050622120848.717e2fe2.rdunlap@xenotime.net>
	 <42B9CFA1.6030702@trex.wsi.edu.pl>
	 <20050622174744.75a07a7f.rdunlap@xenotime.net>
	 <9a87484905062311246243774e@mail.gmail.com>
	 <20050623120647.2a5783d1.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, randy_dunlap <rdunlap@xenotime.net> wrote:
> On Thu, 23 Jun 2005 20:24:15 +0200 Jesper Juhl wrote:
> 
> | On 6/23/05, randy_dunlap <rdunlap@xenotime.net> wrote:
> | >
> | > 6.  Use $EDITOR instead of vim if it is defined (set).
> | >
> | Wouldn't the very best be to try and find the editor to use in the
> | following order?  :
> |
> | A) the value of $EDITOR (if set)
> | B) the value of $VISUAL (if set)
> | C) the first editor in a hardcoded list that exists and is executable
> | (a list could contain for example; vim, vi, elvis, joe, jove, nano,
> | pico, mcedit, emacs )...
> 
> Yes, that sounds better to me.
> 

A similar thing could be done for sending the email;

Look for known email clients - like mutt, pine, elm, check they exist
and are executable, then check if sendmail is available.  Present the
user with a list of the email clients found (and sendmail, if found
and local MTA process is running) and then ask them to pick their
prefered email client/sending method from the list.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
