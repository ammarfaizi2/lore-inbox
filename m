Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752522AbWAFS7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbWAFS7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbWAFS7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:59:19 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:37545 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1752482AbWAFS7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:59:15 -0500
Date: Fri, 6 Jan 2006 16:58:44 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Jens Axboe <axboe@suse.de>
Cc: jesper.juhl@gmail.com, khushil.dep@help.basilica.co.uk,
       viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio: gcc warning fix.
Message-Id: <20060106165844.399a1d07.lcapitulino@mandriva.com.br>
In-Reply-To: <20060106184810.GR3389@suse.de>
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
	<9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
	<20060106184810.GR3389@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jan 2006 19:48:11 +0100
Jens Axboe <axboe@suse.de> wrote:

| > having assigned a value we know that gcc's warning is wrong, idx can
| > never *actually* be used uninitialized.
| 
| Indeed, that's the whole point. For the original submitter, you are not
| the first to submit this. See archives for basically the same thread as
| this one...

 Al Viro got it: I just wanted to make gcc not complain. But
'obfuscate correct code' for it is wrong.

 The code is right, the patch is bad. That's it.

-- 
Luiz Fernando N. Capitulino
