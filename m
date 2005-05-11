Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVEKA7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVEKA7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVEKA7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:59:38 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:22207 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261867AbVEKA7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=foyz500PGykGvQRtitmRwQ7eTaF2EDiPgdwZ7NJCTZeI8uXGixJlgmOmZJoQNsEhClxR3lZFFfYqe/lZ4at5YvC4DlVsvv2kqEq7C9bZYg8pGST63o1u/+kqu4wfo8JtyYbUhC4ONER8QYQdoZbpM0dtEGo/7cnarAStBzaCZos=
Message-ID: <253818670505101759f4db08d@mail.gmail.com>
Date: Tue, 10 May 2005 20:59:32 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
In-Reply-To: <2538186705051017132b6d1909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <253818670505070621784dbd63@mail.gmail.com>
	 <20050510221615.GA4613@kroah.com>
	 <2538186705051017132b6d1909@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On further reflection, how about I work off this patch for now and for
each of the derived attributes submit a separate patch implementing
the callbacks, etc for that attribute along with an example patch
showing how it can be used to benefit some existing code (these
already exist for device and class attributes, so I'll resubmit those
examples).

This way we can be sure that we aren't changing any of the derived
attributes needlessly, and it presents a better view of exactly what
changes I'm making to others I suppose :-).

We should probably document this change somehow in the sysfs
documentation at some point too.

Thanks,
Yani
