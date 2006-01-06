Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWAFTCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWAFTCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAFTCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:02:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3179 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932198AbWAFTCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:02:18 -0500
Date: Fri, 6 Jan 2006 20:04:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: jesper.juhl@gmail.com, khushil.dep@help.basilica.co.uk,
       viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio: gcc warning fix.
Message-ID: <20060106190402.GS3389@suse.de>
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk> <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com> <20060106184810.GR3389@suse.de> <20060106165844.399a1d07.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106165844.399a1d07.lcapitulino@mandriva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06 2006, Luiz Fernando Capitulino wrote:
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

Yes I realize this is what you wanted to do, the warning annoys me to
(using 4.0.2 as well on one machine).

>  The code is right, the patch is bad. That's it.

Indeed :-)

-- 
Jens Axboe

