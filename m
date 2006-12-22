Return-Path: <linux-kernel-owner+w=401wt.eu-S1945920AbWLVFaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945920AbWLVFaR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbWLVFaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:30:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:49678 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945920AbWLVFaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nFxSgdESMHNiLDvEiDYhz8Aqq5DZ7jW9Kprz0P99NraQIgtgiosEFAcqe0vJl2qyhdbkzqmLEHFl8J9GMQCk2/voM3EY/jFNjqlLch/efcLwyelnSjADqTeE834hHjpNBHNjBTxvfZVaCOyyOgLo/4liUDp4xDCPVqsnsHcB9u4=
Message-ID: <652016d30612212130v433b4e70uc2148278c7ee7198@mail.gmail.com>
Date: Fri, 22 Dec 2006 11:15:14 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Bhanu Kalyan Chetlapalli" <chbhanukalyan@gmail.com>
Subject: Re: Linux disk performance.
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <7d15175e0612211614y3ce090fcn38cbcaced76b1024@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
	 <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
	 <458788D7.2070107@yahoo.com.au>
	 <652016d30612200317i6d33d097xe55971750e83cd97@mail.gmail.com>
	 <7d15175e0612211614y3ce090fcn38cbcaced76b1024@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com> wrote:
>
> I am assuming that your program is not seeking inbetween writes.
>
> Try disabling the Disk Cache, now-a-days some disks can have as much
> as 8MB write cache. so the disk might be buffering as much as it can,
> and trying to write only when it can no longer buffer. Since you have
> an app which continously write copious amounts of data, in order,
> disabling write cache might make some sense.
>

Thanks  for the suggestion but the performance was terrible when write
cache was disabled.

-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
