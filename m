Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752451AbWCFV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWCFV77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbWCFV76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:59:58 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:56608 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752451AbWCFV75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:59:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jcZTCIZoHhlIRuIB/MvDOuP3zVk+JrMnr/KtOt3jdG5Bs/nzTHHfa2UXwq7TLSc9he10gVzfTdXs4rJNmPskOXL4NnQBEnpzobUBbyQPrG6iymw6ehiveJ1fq4Qd1pC+emHD1D78LA6riJESg/kPQOJSegzxgFUV+/biiVxpfxM=
Message-ID: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:59:56 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: initcall at ... returned with error code -19 (Was: Re: 2.6.16-rc5-mm2)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
>

With this kernel I sometimes get :
  initcall at 0xc0432790: rng_init+0x0/0xa0(): returned with error code -19
and sometimes :
  initcall at 0xc0428240: init_hpet_clocksource+0x0/0x90(): returned
with error code -19

I haven't paid enough attention to be able to say if some boots had
other variations, but at least the two above have been observed.

2.6.16-rc5-git8 is fine.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
