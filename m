Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289088AbSAGCgZ>; Sun, 6 Jan 2002 21:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289086AbSAGCgF>; Sun, 6 Jan 2002 21:36:05 -0500
Received: from weta.f00f.org ([203.167.249.89]:47301 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S289084AbSAGCf4>;
	Sun, 6 Jan 2002 21:35:56 -0500
Date: Mon, 7 Jan 2002 15:38:54 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Marvin Justice <mjustice@austin.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Gerrit Huizenga <gerrit@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020107023854.GA26751@weta.f00f.org>
In-Reply-To: <20020106032030.A27926@redhat.com> <E16NFxv-0005e4-00@the-village.bc.nu> <20020106233726.GA26491@weta.f00f.org> <200201070215.g072F0u3010729@sm14.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201070215.g072F0u3010729@sm14.texas.rr.com>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 08:18:33PM -0600, Marvin Justice wrote:

    Here's my (probably simple minded) understanding. With the PSE bit
    turned on in one of the x86 control registers (cr3?), page sizes
    are 4MB instead of the usual 4KB. One advantage of large pages is
    that there are fewer page tables and struct page's to store.

Ah, I knew 4MB pages were possible... I was under the impression _all_
pages had to be 4MB which would seem to suck badly as they would be
too coarse for many applications (but for certain large sci. apps. I'm
sure this would be perfect, less TLB thrashing too with sparse
data-sets).

On the whole, I'm not sure I can see how 4MB pages _everywhere_ in
user-space would be a win for many people at all...


  --cw
