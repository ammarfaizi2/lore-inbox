Return-Path: <linux-kernel-owner+w=401wt.eu-S932710AbWLaD6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWLaD6F (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 22:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWLaD6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 22:58:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:33762 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbWLaD6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 22:58:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elbTtZ9f2qQMJMl9Tcg8bEfytIP+U01Vd1IixEVD0agvuAdYDGjtgNBCpZ0IFZyCYLPFoyfKrqTIm+j5sTlKPby7BeMtiWAF1yoNAPa7B31dcyK9m5y9I9zqAEz7qPnm50KV9Blq1pQXXTD+tn4XgqW/WGJaJAnFu02mL0s7lE8=
Message-ID: <b6a2187b0612301958k7d9a6d27v53c7f5592cb1a1b5@mail.gmail.com>
Date: Sun, 31 Dec 2006 11:58:00 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: any chance to bypass BIOS check for VT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <459629F5.2000602@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0612290230g7e494670h6396e2f0a4ecea10@mail.gmail.com>
	 <459629F5.2000602@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/06, Avi Kivity <avi@argo.co.il> wrote:

> When it says "disabled by bios" it means what it says.  There is no
> workaround other than going to the bios and enabling it; if your bios
> doesn't support enabling VT, complain to your vendor.

Ok, I tried and proved the point. Kernel crashed.


> A ps/2 mouse should be enabled automatically.  What makes you think it
> is disabled?

It's enabled, but I don't see the mouse. If I cat /proc/mouse, I see
the raw data, but pointer doesn't show up in the screen.

Thanks,
Jeff.
