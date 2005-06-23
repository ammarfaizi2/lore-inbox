Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVFWSYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVFWSYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:24:29 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:46814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262647AbVFWSYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:24:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EN3Ujo8n7BlYM7cwkjgoO4z/eyQEQrgXutOy3xw7AX2WflbBiVha9HFVO2B22cSN5/S8+/dW8nLE+CPynPaP91n2/cGzImW+Neo7iO8wgfGdMUaSlDWFmfokcYFRKhR6Tzb18h/ZsoIKuB2GOoMcKpHAWsmahtUrvuTHESXra/M=
Message-ID: <9a87484905062311246243774e@mail.gmail.com>
Date: Thu, 23 Jun 2005 20:24:15 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Script to help users to report a BUG
Cc: Micha__ Piotrowski <piotrowskim@trex.wsi.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050622174744.75a07a7f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	 <20050622120848.717e2fe2.rdunlap@xenotime.net>
	 <42B9CFA1.6030702@trex.wsi.edu.pl>
	 <20050622174744.75a07a7f.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, randy_dunlap <rdunlap@xenotime.net> wrote:
> 
> 6.  Use $EDITOR instead of vim if it is defined (set).
> 
Wouldn't the very best be to try and find the editor to use in the
following order?  :

A) the value of $EDITOR (if set)
B) the value of $VISUAL (if set)
C) the first editor in a hardcoded list that exists and is executable
(a list could contain for example; vim, vi, elvis, joe, jove, nano,
pico, mcedit, emacs )...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
