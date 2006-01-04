Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWADPIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWADPIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWADPID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:08:03 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:56744 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751410AbWADPIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:08:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yj4QsuXfD4HpyitKphufs8wjhF5uSafguCCJOuw86ZH2BySr1m5A/dWIppWYqtHx4Hxtnj/t/FuPruHI/HiMlrB8VL4n79yNWEuOR+4tEvGL6E9mcjEA10YfjRCWLNTXXQfAVrqRMdAWutws0kqKVeO1NpR6uQuTXmicfn3bjxA=
Message-ID: <81b0412b0601040707r355da9eey1b6332d0563dd3a4@mail.gmail.com>
Date: Wed, 4 Jan 2006 16:07:57 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: xerces8 <xerces8@butn.net>
Subject: Re: Possible GPL violation in Canyon CN-WF514 WLAN router
Cc: tech@lists.gnumonks.org, linux-kernel@vger.kernel.org
In-Reply-To: <WorldClient-F200601032031.AA31410090@butn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <WorldClient-F200512251652.AA52540032@butn.net>
	 <WorldClient-F200601032031.AA31410090@butn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, xerces8 <xerces8@butn.net> wrote:
>  Help disecting the FW package [4]. It is a ZIP archive containing
>  a text file and a *.bin file. This *.bin file appears to be some kind
>  of another archive, containing two files : webpages-6104ipc.bin
>  and vmlinux.bin

$ file WF514-200713T5.img
WF514-200713T5.img: PPCBoot image

Which probably (I didn't look) points to http://ppcboot.sourceforge.net/
