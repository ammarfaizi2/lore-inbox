Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWALTrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWALTrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWALTrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:47:01 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:985 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161215AbWALTrA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:47:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IUZhCFJ32fPcDedUdsQr5O4vxns0LMbwdiuxQrU0z04dqMMBLGQnME4Iovvh98VluUy1lrzzHHnYSmxTOLLLmWNqWsXN9bSUiAlRNum+7Sv3Wq+2MHjgiIRL1khpp+EIPyY6BoxkDc9dqfVEGO3l6afX04fLDIwfEXmRXH+W2FI=
Message-ID: <9a8748490601121146g780cc826pcabd4215658376be@mail.gmail.com>
Date: Thu, 12 Jan 2006 20:46:59 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Brian D. McGrew" <brian@visionpro.com>
Subject: Re: Capturing All Kernel Messages
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0970971@chicken.machinevisionproducts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <14CFC56C96D8554AA0B8969DB825FEA0970971@chicken.machinevisionproducts.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Brian D. McGrew <brian@visionpro.com> wrote:
> So I'm trying to build a new special kernel and of course, as Murphy
> says, it'll blow up the first 1,000 times!  I need to capture the boot
> messages because I'm getting a lot of errors scrolling by before the
> kernel panics and I'm toast and have to revert back to my old kernel.
> Once I revert back to my old kernel, all my previous messages are lost
> and dmesg does me no good!
>
> How can I make the kernel output to a file or some other means as soon
> as it starts loading so I can capture this stuff?
>

serial console, net console or console on line printer.
Check the Documentation/ subdir in the kernel source for the details.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
