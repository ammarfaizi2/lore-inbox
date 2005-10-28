Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVJ1CEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVJ1CEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVJ1CEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:04:36 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:24558 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965056AbVJ1CEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:04:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TvREOOGWejpd58kpvAtHCgR+r5umd0Zu5HdfypWrf5Dma08RMXoHBUHqKVm+c1sh6ZGgr+h2C38CKQLDLW/9uvdj3BtHeE7yU4uNddMalBKk4TGaETnJOoVi0S8uMjP51qZp9neRLVFTGLHDCFghYrVV/o5CYR3fWHAYzVwqWRs=
Message-ID: <489ecd0c0510271904p127df5a7pe8793ba47d635538@mail.gmail.com>
Date: Fri, 28 Oct 2005 10:04:35 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Re: The "best" value of HZ
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200510280118.42731.cloud.of.andor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510280118.42731.cloud.of.andor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  yes,  our Blackfin CPU (from Analog Device) is team interested in
it.  Dynamically modify HZ will be useful when we evaluate the
performance.

On 10/28/05, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> Hi,
>
>     during the last years there has been a lot of discussion about the "best"
> value of HZ... On i386 was 100, then became 1000, and finally was set to 250.
> I'm thinking to do an evaluation of this parameter using different
> architectures.
>
> Has anybody thought to give the possibility to modify the value of HZ at boot
> time instead of at compile time ? This would allow to easily test different
> values on different machines and create a table containing the "best" value
> for each architecture...  At this moment, instead, we have to recompile the
> kernel for each different value :(
>
> Do you think there would be much work to do that ?
> Do you think it would be a desired feature the knowledge of the best value for
> each architecture with more precision ?
>
> Thanks,
>
>       Claudio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
