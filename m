Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUJEOKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUJEOKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbUJEOKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:10:12 -0400
Received: from relay.pair.com ([209.68.1.20]:58891 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269048AbUJEOCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:02:33 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41629C78.60203@kegel.com>
Date: Tue, 05 Oct 2004 06:07:04 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote:
 > Curiosity: Is this defined in any UNIX standard?

No.  See
http://www.opengroup.org/onlinepubs/009695399/functions/open.html
which leaves it undefined.

http://www.pasc.org/interps/unofficial/db/p1003.1/pasc-1003.1-71.html
says implementations have to allow setting O_NONBLOCK even if they
ignore it.

http://www.ussg.iu.edu/hypermail/linux/kernel/9911.3/0530.html
claims other Unixes and NT implement it.

There's a thread that discusses this in a bit of detail, and
suggests that older Solaris might implement it:
http://lists.freebsd.org/pipermail/freebsd-arch/2003-April/000132.html
http://lists.freebsd.org/pipermail/freebsd-arch/2003-April/000134.html

Googling for O_NONBLOCK disk seems to be good.  I'd google more
but my baby is calling :-)
- Dan
-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
