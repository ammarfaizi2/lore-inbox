Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUKAHl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUKAHl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 02:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKAHlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 02:41:55 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:39334 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261504AbUKAHly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 02:41:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dto38kfmsIIaZZ3zHfA7ad2P/1IP9pm3GKDCzfsyB0eCVNShyoF2QpEKRuxxLAx11Mc5epsaG8MavuKpfoeUSX9s8Xxt/Azmhuiw7iZQ3RC3yrr8UXuxjYYz3voKenbz1NA5qe0fZiuiQy2mfMlsUWpKcoL1bbCfJ+bkln9v4aQ=
Message-ID: <21d7e9970410312341404c5f73@mail.gmail.com>
Date: Mon, 1 Nov 2004 18:41:53 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391041031223761ffbf7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e47339104102311229276d8@mail.gmail.com>
	 <1099288890.25525.4.camel@localhost.localdomain>
	 <9e473391041031223761ffbf7f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The code in DRM CVS works and it has no DRM() macros, inter_module_xx
> is gone, and it splits DRM in to DRM-core plus personality modules.
> Now all we have to do is get it merged into the kernel.  The diffs are
> huge due to lindent reformatting and removal of DRM() macros.

I'm about 50percent through a working tree now ... hopefully I'll
release it for -mm in the next evening or two,

I've got it nearly building completly now then there'll be some
testing on it to do..

Dave.
