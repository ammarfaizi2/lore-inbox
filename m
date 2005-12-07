Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVLGPOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVLGPOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVLGPOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:14:49 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:42118 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVLGPOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D4FoRj0GDBPtmyPtTmV1vqMqsFs4xku3LZMGB3Zy6s/7zFoAFxw4usUy7MmGg9kB3VDjpRaRNzGLgAANYjJcJecAz0yCpv+7JIUDnWC6vMRfnYn1tn2iwAY02actgXLl0Kgol0iwg1uAl0yF+lKi1B+ZgEO+ELvBHR7/a7DcK80=
Message-ID: <84144f020512070714m6a1452d5x9565758cdc8aa318@mail.gmail.com>
Date: Wed, 7 Dec 2005 17:14:46 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Marco Correia <mvc@di.fct.unl.pt>
Subject: Re: slow boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512071506.40336.mvc@di.fct.unl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512071027.26364.mvc@di.fct.unl.pt>
	 <84144f020512070701s344f721dsd92f33d5f275a453@mail.gmail.com>
	 <200512071506.40336.mvc@di.fct.unl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/05, Marco Correia <mvc@di.fct.unl.pt> wrote:
> Thanks for the reply. I think my problem has something to do with this
> http://bugzilla.kernel.org/show_bug.cgi?id=5165, however I just installed
> kernel 2.6.15_rc5 and the problem is still there, but now it seems that it
> slows down even before the init begins.
>
> As soon as I have the time I'll look into git, since I never used it before.

Here's a good tutorial: http://linux.yyz.us/git-howto.html. You
probably should first see if 2.6.11 and 2.6.12 have the problem.
Pre-2.6.11-rc2 changesets are in old-2.6-bkcvs git tree (which used to
be Bitkeeper) and rest are in linux-2.6.git as seen here:
http://www.kernel.org/git/.

                          Pekka
