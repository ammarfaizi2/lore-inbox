Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263691AbUJ3LRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbUJ3LRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUJ3LRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:17:10 -0400
Received: from mproxy.gmail.com ([216.239.56.246]:33676 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263691AbUJ3LRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:17:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SXwo7AiRw1FOLTDx+n6PcybXNH/9N2ihLmFdLbEtmP0Wl16feNAcPXWZuD9rokxVQ0l/N2ZSqMpgCSuQsLBWs9JSvFb2mSXQBYsQIgk+C1d9g9l+jaFAKwYLcj2vVSEOFgJq7zIib+c6NZEyXpJiXdw3NuZM4zsP3h65BAZyxPM=
Message-ID: <21d7e997041030041748b60ce7@mail.gmail.com>
Date: Sat, 30 Oct 2004 21:17:02 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: status of DRM_MGA on x86_64
In-Reply-To: <21d7e99704103004155d2826fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	 <1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	 <41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	 <1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
	 <p734qkd0y0n.fsf@verdi.suse.de>
	 <21d7e99704103004155d2826fb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry missed the list....


---------- Forwarded message ----------
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 30 Oct 2004 21:15:45 +1000
Subject: Re: status of DRM_MGA on x86_64
To: Andi Kleen <ak@suse.de>


>
> It was solved long ago for the Radeon driver by Egbert Eich.
> But for some unknown reason the DRI people never merged his patches.

Because no-one agreed that his solution was clean enough for use,
no-one contributed well described patches of the separate pieces to
drm or dri,

At the moment any solution to the 32/64-bit DRI will either break pure
64-bit systems or break 32/64-bit mixed systems, nobody has stepped
forward and said that either of these are acceptable, and no drm
developer has the hardware to work on it,

This 64-bit vs 32/64-bit stuff has been on my drm todo list for ages
but I've neither received clean patches or someone who has the test
environment to convince me that breaking one or other of the currently
working systems is acceptable... so we are currently in a state of
breaking backwards compat for 64-bit vs breaking backways compat for
32/64-bit.... I've no idea which one is acceptable, and I'm not going
to spend time developing a patch for one to have it refused because it
breaks compat with the other....

Someone needs to make the big decision, (IMHO only Linus or Andrew can
really make it as it's their kernels that will have the issues...)

Dave.
