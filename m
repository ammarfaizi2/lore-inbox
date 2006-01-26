Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWAZAEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAZAEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWAZAEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:04:04 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:40566 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbWAZAEC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:04:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQWq2ileImPsoV3as0z6GigW44VdrTINuIZT+YVFYHsLlswbTl1s1FCInCAIdCqzovPED4iCgc/BDSpmE1UZAfH2Em44Nrzacb6LTrFCyhZjohtqmk3+Q/7HaAVD425zSJR7FZ/5Xul9imi0ciJgMJ5mLAzmW13Zki45lGfGZx4=
Message-ID: <9e4733910601251603n543dbe3ej93286743b01eef6e@mail.gmail.com>
Date: Wed, 25 Jan 2006 19:03:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <OF9B696195.5A30AEF3-ON882570FF.006879C2-882570FF.006D26D2@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D28189.3080407@argo.co.il>
	 <OF9B696195.5A30AEF3-ON882570FF.006879C2-882570FF.006D26D2@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Bryan Henderson <hbryan@us.ibm.com> wrote:
> >Perhaps you'd be interested in single-level store architectures, where
> >no distinction is made between memory and storage. IBM uses it in one
> >(or maybe more) of their systems.

Are there any Linux file systems that work by mmapping the entire
drive and using the paging system to do the read/writes? With 64 bits
there's enough address space to do that now. How does this perform
compared to a traditional block based scheme?

With the IBM 128b address space aren't the devices vulnerable to an
errant program spraying garbage into the address space? Is it better
to map each device into it's own address space?

--
Jon Smirl
jonsmirl@gmail.com
