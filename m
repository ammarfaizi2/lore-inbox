Return-Path: <linux-kernel-owner+w=401wt.eu-S1423119AbWLVOpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423119AbWLVOpM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWLVOpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:45:12 -0500
Received: from ip127.bb146.pacific.net.hk ([202.64.146.127]:57847 "EHLO
	mailhub.stlglobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423074AbWLVOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:45:10 -0500
Message-ID: <458BEF72.6050801@tausq.org>
Date: Fri, 22 Dec 2006 22:45:06 +0800
From: Randolph Chung <randolph@tausq.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Randolph Chung <randolph@tausq.org>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu> <20061221181156.GG3958@flint.arm.linux.org.uk> <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu> <20061221185512.GH3958@flint.arm.linux.org.uk> <E1GxTED-0000yy-00@dorka.pomaz.szeredi.hu> <458B1E06.1030209@tausq.org> <20061222084318.GA5132@flint.arm.linux.org.uk>
In-Reply-To: <20061222084318.GA5132@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is the documentation wrong?
> 
> Yes.  As I've already explained there is no guarantee that
> get_user_pages() is only called to obtain pages for the current
> process, and flush_anon_pages() is called irrespective of which
> user process is being 'got'.

ok, it's easy enough to fix, I'm just trying to point out that it's 
being implemented on parisc according to the documentation.

randolph



