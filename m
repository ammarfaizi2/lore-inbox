Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbUKAKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbUKAKQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 05:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUKAKQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 05:16:49 -0500
Received: from mproxy.gmail.com ([216.239.56.247]:60176 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261737AbUKAKQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 05:16:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iDm3tGsdUZGMpy6YyBd7tPHqm1fQhaYHd+djyXBm0GaDQvx5kLV0HonUAoMdRccd+VKhUCUuFRb/sCk60pwiN4MmER+J1QogTbS8c9ugpHdqgGqBIIR5blViq9pc+wBmbvZbPT8EnMBA9y0kSWppJZwzAcdJQbjJsew5PMW2qy8=
Message-ID: <21d7e99704110102161132d37b@mail.gmail.com>
Date: Mon, 1 Nov 2004 21:16:43 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Egbert Eich <eich@suse.de>
Subject: Re: status of DRM_MGA on x86_64
Cc: Andi Kleen <ak@suse.de>, Thomas Zehetbauer <thomasz@hostmaster.org>,
       linux-kernel@vger.kernel.org, idr@us.ibm.com
In-Reply-To: <16774.1839.343824.305232@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	 <1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	 <41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	 <1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
	 <p734qkd0y0n.fsf@verdi.suse.de> <16774.1839.343824.305232@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I solved it for RADEON, MGA and R128.
> It would be interesting to solve this for the i915 driver, too,
> and possibly some others.
> 
> That it hasn't been merged into DRI yet is a shame. Appearantly
> nobody has ever realized why this stuff is useful. Unfortunately
> I don't have the time for lobbying it.
> It's a very boring undertaking to have to port this from one DRI
> version to the next.

Ian, can you look at this I think you are the best person (maybe
Keithw) to tell whether this stuff breaks compat in any direction,.
Egbert you may not want to lobby for it but all I personally want to
know is what it might potentially break in terms of backwards
compatiblity.... from SuSEs point of view as long as a distro is
consistent then you are okay, for us the whole keeping DRIs built
against older kernels working with newer kernels is the only real
issue...

Hopefully Ian can look at the patch and decide on it....

Dave.

Dave.
