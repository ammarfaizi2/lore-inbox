Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWIZXI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWIZXI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWIZXI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:08:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:62494 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965128AbWIZXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a2aO/ACZTpgfY7Y2G+JR8UrqyCQP++QWH+E2wRyhE784//2fvbQEaD0I+DWidkbtEJzp6n6mG5bjWpW87jgck0mKx+6Pz2vitUBcu5ksrTmSeoH9wR3bjeUFLYKeljVvUiUB9lZ37CpNuZ74RYiMX9+ICzdOWPpKrj0YCp55IHE=
Message-ID: <9a8748490609261608h25d66ed9rde23a1319578dbb7@mail.gmail.com>
Date: Wed, 27 Sep 2006 01:08:27 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dimitri Chausson" <tri2000@gmx.net>
Subject: Re: serious kernel messages in /var/log/messages
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060926195605.e0e9efa8.tri2000@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060926195605.e0e9efa8.tri2000@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/06, Dimitri Chausson <tri2000@gmx.net> wrote:
[... snip ...]
> I already suspect a hardware problem, but I do
> not know what to start with. '

memtest86 and/or memtest86+ are usually good starting points :

http://www.memtest86.com/
http://www.memtest.org/

faulty memory can often lead to very strange and seemingly random
problems, so give the machine a good run with a mem testing tool like
one of the above - I'd suggest running all tests of memtest86+ for
some 8-12 hours - if the machine survives that without errors then
your RAM is probably OK.


If you suspect your CPU (or just want to make sure) then a program
like cpuburn can be useful :

http://pages.sbcglobal.net/redelm/


If you suspect your harddrive, then smartmontools is probably what you
are looking for:

http://smartmontools.sourceforge.net/


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
