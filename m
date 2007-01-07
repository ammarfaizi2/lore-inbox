Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbXAGF6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXAGF6e (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 00:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbXAGF6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 00:58:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:51126 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbXAGF6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 00:58:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PxnC8Lt+G2m+7/3C21tz5omY4H5AA3cc4MQ9QIX05dDtjn3wkNG9qn6Swvw29w60hRj89Gqm8/3PVW4Ov321fNj+7PMGnQIcztaWHzjTeo2oSgkQKmW2eovaQMCgJkLeZGQgUGvZ7SQ7LEp9lGkSrx5o/mIVlWobx8tThA3fsQ4=
Message-ID: <cd32a0620701062158g28dfbe57g7d789e8c378e2625@mail.gmail.com>
Date: Sun, 7 Jan 2007 16:28:32 +1030
From: "Tom Lanyon" <tomlanyon@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Martin Michlmayr" <tbm@cyrius.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <cd32a0620701061806y719fcf8bwd61daf05dac1bc3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
	 <4590F9E5.4060300@yahoo.com.au>
	 <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
	 <cd32a0620701061806y719fcf8bwd61daf05dac1bc3c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Tom Lanyon <tomlanyon@gmail.com> wrote:
> I've been following this thread for a while now as I started
> experiencing file corruption in rtorrent when I upgraded to 2.6.19. I
> am using reiserfs.

However, moving to 2.6.20-rc3 does indeed seem to fix the issue thus far...

-- 
Tom Lanyon
