Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLJNUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLJNUx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 08:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVLJNUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 08:20:53 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:57751 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932331AbVLJNUw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 08:20:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YJaBvhZtGhcyMHlm6DsKLip1fb9uetUBfGpBU+E/Ykr0Nk9KZ2M9lt7GkcVQZKZuuwnXhtiCXhkbrpwoTUTXUOv6ubAQJ/9tDaxDOjHcv2mleIoMVQ/+ISZeUoOcDJx+FKwq22tKpYTXx4DUyBsw7s6ler+Kaypf5RazlhIKgLw=
Message-ID: <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com>
Date: Sat, 10 Dec 2005 18:50:51 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: yen <yen@eos.cs.nthu.edu.tw>
Subject: Re: IRQ vector assignment for system call exception
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051208080435.M54890@eos.cs.nthu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051208080435.M54890@eos.cs.nthu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, definetely a historical reason. System libraries need to know
this vector to invoke system call.

-Gaurav


On 12/8/05, yen <yen@eos.cs.nthu.edu.tw> wrote:
> Hi:
>    I have a quwstion. Why the number 128 is reserver for system call exception in
> interrupt vectors? Why not other numbers? Are there any historical reasons?
> thanks.
>
> --
> Open WebMail Project (http://openwebmail.org)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
- Gaurav
my blog: http://lkdp.blogspot.com/
--
