Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbUKAN75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUKAN75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbUKANxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:53:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:40589 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262412AbUKANxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:53:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16774.16025.448235.509972@suse.de>
Date: Mon, 1 Nov 2004 14:48:09 +0100
From: Egbert Eich <eich@suse.de>
To: Dave Airlie <airlied@gmail.com>
Cc: Egbert Eich <eich@suse.de>, Andi Kleen <ak@suse.de>,
       Thomas Zehetbauer <thomasz@hostmaster.org>,
       linux-kernel@vger.kernel.org, idr@us.ibm.com
Subject: Re: status of DRM_MGA on x86_64
In-Reply-To: airlied@gmail.com wrote on Monday, 1 November 2004 at 21:16:43 +1100 
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	<1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	<41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	<1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
	<p734qkd0y0n.fsf@verdi.suse.de>
	<16774.1839.343824.305232@suse.de>
	<21d7e99704110102161132d37b@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie writes:
 > 
 > Ian, can you look at this I think you are the best person (maybe
 > Keithw) to tell whether this stuff breaks compat in any direction,.
 > Egbert you may not want to lobby for it but all I personally want to
 > know is what it might potentially break in terms of backwards
 > compatiblity.... from SuSEs point of view as long as a distro is
 > consistent then you are okay, for us the whole keeping DRIs built
 > against older kernels working with newer kernels is the only real
 > issue...

Right. I know. I've looked into this.
I thought I had fixed the last remaining backward compatibility 
between kernel and DRI (libraries and Xserver) by adding compatibility
ioctls. 
I still plan to revisit this issue and see if I can modify the code 
such that I don't need those compatibility ioctls.

 > 
 > Hopefully Ian can look at the patch and decide on it....
 > 

OK. An earlier version is in the freedesktop CVS (#943). If you want 
I make a port to the DRI head. Unfortunately I probably won't be able 
to get at it for the next 2 - 3 weeks.


	Egbert.


