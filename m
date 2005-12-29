Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVL2LqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVL2LqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVL2LqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:46:13 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:18952 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932593AbVL2LqN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:46:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gI15Tp4cUT2850xjLz11WfVnGexi27QSw72nKowh/ko/jqRrzs/DmWxFtm2O5mhjxrEBpml6yPTzH6VBumRK/i2l2gzn3sSLLkRfvDDahmMyDCMWWDV73g+lviFs3wGf+pFriam1UBqqzH62Z9n8kSPQ/3psfo+LgYCthWQ19Io=
Message-ID: <71a0d6ff0512290346v5909ce06k47401075955ad44a@mail.gmail.com>
Date: Thu, 29 Dec 2005 14:46:12 +0300
From: Alexander Shishckin <alexander.shishckin@gmail.com>
To: "pretorious ." <pretorious_i@hotmail.com>
Subject: Re: Redefinition error while compiling LKM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135854129.2935.13.camel@laptopd505.fenrus.org>
	 <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, pretorious . <pretorious_i@hotmail.com> wrote:
> >
> >and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
> >that matter)
> >
> >
>
> Trying to override certain syscalls (mknod ...)
You do not intercept syscalls.
You do not intercept syscalls from a kernel module.
You do not include libc headers in the kernel code.

--
I am free of all prejudices. I hate every one equally.
