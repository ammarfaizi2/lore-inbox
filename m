Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWAFTFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWAFTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAFTFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:05:09 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:52155 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932473AbWAFTFB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:05:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X584vD+4M7WiCxDkt5AocTbCT80lS1nZEeq7jYNat1xwkU/RmjW5uOshRa1nNT1S/+o7Rj0EBQzcLxfOIgZqeGOP+uEDaOiWuYYdgVDdssLAJJchRNaKc9osIrJMPUEup4+oJiwj641l2yHUDHth8OOHaZK9KpBdmOmeVHoSX3I=
Message-ID: <9a8748490601061105s865d659ycfab118c21eb371c@mail.gmail.com>
Date: Fri, 6 Jan 2006 20:05:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] bio: gcc warning fix.
Cc: Jens Axboe <axboe@suse.de>, khushil.dep@help.basilica.co.uk,
       viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060106165844.399a1d07.lcapitulino@mandriva.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
	 <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
	 <20060106184810.GR3389@suse.de>
	 <20060106165844.399a1d07.lcapitulino@mandriva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Luiz Fernando Capitulino <lcapitulino@mandriva.com.br> wrote:
>
> On Fri, 6 Jan 2006 19:48:11 +0100
> Jens Axboe <axboe@suse.de> wrote:
>
> | > having assigned a value we know that gcc's warning is wrong, idx can
> | > never *actually* be used uninitialized.
> |
> | Indeed, that's the whole point. For the original submitter, you are not
> | the first to submit this. See archives for basically the same thread as
> | this one...
>
>  Al Viro got it: I just wanted to make gcc not complain. But
> 'obfuscate correct code' for it is wrong.
>
>  The code is right, the patch is bad. That's it.
>
Yeah, but thanks for trying.
You may have been wrong in this case (and learned to verify your
patches more thoroughly), but the effort to try and review and help
improve the kernel is apreciated.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
