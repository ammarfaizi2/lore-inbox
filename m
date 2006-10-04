Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWJDWhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWJDWhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJDWhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:37:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:238 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWJDWhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWkGvpb+2YSppCneXrNHmof79U0cMKYH3QcukvrZre2wWBZ9ytxmKI1sMavhMr1hWdALrVA/fq4FcoJAglF+e0Dz8iM0zsv4zH6eK1YDLI2bINMK+VpsXm+qB4uZjsO2kA+MFZy29LeF+uLkdAomgbjStY3qTqRFVm9GAZidcpU=
Message-ID: <a762e240610041537n6a2ffd1cja3c18ce99b714b0f@mail.gmail.com>
Date: Wed, 4 Oct 2006 15:37:36 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Steven Truong" <midair77@gmail.com>
Subject: Re: kexec / kdump kernel panic
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <28bb77d30610041438r3c3dfd8ejc7344761704747fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com>
	 <200610040346.k943kvwM006684@turing-police.cc.vt.edu>
	 <28bb77d30610041438r3c3dfd8ejc7344761704747fd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Steven Truong <midair77@gmail.com> wrote:
> Hi, Valdis.  No, I actually used 2 different kernels for this:  one
> for system kernel and the other for captured/crash kernel.
>
<snip >
> CONFIG_PHYSICAL_START=0x1000000
<snip>
> CONFIG_PHYSICAL_START=0x1000000
>

if both cases you have the same CONFIG_PHYSICAL_START?  I thought the
kexec kernel needed to start at a diffrent location then the original
kernel?

Thanks,
 Keith
