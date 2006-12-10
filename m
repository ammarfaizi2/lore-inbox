Return-Path: <linux-kernel-owner+w=401wt.eu-S1760665AbWLJLOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760665AbWLJLOs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760672AbWLJLOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:14:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:44263 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760665AbWLJLOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:14:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tfs/Ay1t8bq9VuSoxa1F3w1kUB1xlMhyVnRdCVhXrsKNfG5AeHTGh/W0OqK48aMZjrhoLz2pNncMd3OGenaZ1kTYwCXFBTXhNAGEYUd/0uhBAIAA7O1U+JRRHxFKLL/hnlUGsCe4yvBSZopwXAhOxgxyKoPb9NV+1HYrEoh01rU=
Message-ID: <9a8748490612100314i636a16e1le173f26e1c5bc922@mail.gmail.com>
Date: Sun, 10 Dec 2006 12:14:46 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] [DISCUSS] Optimizing linux applications with the help of the kernel.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <464448.56474.qm@web55602.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <464448.56474.qm@web55602.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Amit Choudhary <amit2030@yahoo.com> wrote:
> Hi All,
>
> I just had an idea for improving the performance of linux applications with some help from the
> kernel. Let's say that I have to make a copy of a file. So, I read the input file into a buffer
> and then write the buffer to the output file.
>
> In both these cases the same data is coming from kernel_to_user and then from user_to_kernel. If
> this can be short-circuited, that is, from kernel_to_kernel then the performance can be increased
> a lot.
>

See the linux specific splice() syscall - "man 2 splice".

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
