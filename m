Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWEFUeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWEFUeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 16:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWEFUeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 16:34:11 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:20189 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751115AbWEFUeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 16:34:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWWK7YM63QXikuKecA4eVNDjyUC2wNxTt7RtH4zsrpjHt+aHBGfFgRD6aTBtrdsHZ9f4u1uaDTACkuD/g4NogHSqRwaMNOhR6mqnKJbido0UpkA5eG1anCdGh6wD14wpVnAIzFk2l/ioCsCHDkCaKNkyCr8MIPtRS9Pnt2K8qmk=
Message-ID: <2151339d0605061334s117b46d6x60cdb3dd83747d67@mail.gmail.com>
Date: Sat, 6 May 2006 13:34:10 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605061232.52303.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <200605041922.52243.david-b@pacbell.net>
	 <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
	 <200605061232.52303.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all suggestions.  I tried passing mem=2048m to the kernel. 
This is with 2.6.16.13.  This did fix the USB ehci problem.  Of course
the kernel only sees half of my RAM, so this is not a satisfactory
long-term workaround.

As for your other suggestions, I'm not sure how to implement those. 
I'm not a kernel developer.  If you can give me more specific
instructions or send me a patch I would be happy to try those out. 
Otherwise, if you feel that this is unrelated to the other entries in
bugzilla with similar symptoms, I would be happy to submit a bug
report.
