Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWGLVb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWGLVb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGLVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:31:59 -0400
Received: from smtp-out.google.com ([216.239.33.17]:31260 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751421AbWGLVb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:31:58 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=kwdy1IO2rMEw8bkwmt8FYEPvPDZDxT1bDy30L3XRfVWpUEE9kScARDPlo2WCJ/5Fy
	y5rNQ5vHfsD2ymNwAhpoQ==
Message-ID: <44B56A2F.5010204@google.com>
Date: Wed, 12 Jul 2006 14:31:27 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com>	 <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>	 <44B55A9E.2010403@us.ibm.com>  <44B55AEA.1010608@google.com> <1152739939.22840.1.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1152739939.22840.1.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not able to "insmod xfs.ko" on my x86-64 machine :(
> 
> elm3b29:~ # modprobe xfs
> FATAL: Error inserting xfs (/lib/modules/2.6.18-rc1-
> mm1/kernel/fs/xfs/xfs.ko): Cannot allocate memory
> 
> #dmesg shows ..
> 
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 328 bytes percpu data
> Could not allocate 328 bytes percpu data
> Could not allocate 328 bytes percpu data
> 
> 
> Whats happening here ?



Dunno, but I built it statically, and didn't have that problem ;-)
The default config on elm3b6 should work.
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
