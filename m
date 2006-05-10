Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWEJIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEJIcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWEJIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:32:10 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:15968 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964849AbWEJIcJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:32:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMmTb3xSdfpV/faWX7ewppJL8kZWYMYz9jABU+JNYs1k5r3twyQ8ufxWYQT8BulbF+gNKA0dNkIDdQEeSjzaTYWnEduDtr0i72xrVJkA593mN2hh14wrBJJiLOJPtdRKCl2Oi5/3ocwf0Jrwo02R5r/hAvWUkyGAoPlQyvAXEKc=
Message-ID: <b263e5900605100132m62cbfe16yda4213c97ae363e@mail.gmail.com>
Date: Wed, 10 May 2006 01:32:08 -0700
From: "Dan Carpenter" <error27.lkml@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: How to read BIOS information
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147099994.2888.32.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445F5228.7060006@wipro.com>
	 <1147099994.2888.32.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven:
> But that's the best you can do.
> (well you could grovel through the acpi tables just like the kernel
> does, but you really don't want to do that from userspace)

Obviously that would be tricky in this case.  But in general it seems
like writing an acpi table parser should be  doable.  Couldn't you
just search through /dev/mem like dmidecode does?  What's the
difficult part?

regards,
dan carpenter
