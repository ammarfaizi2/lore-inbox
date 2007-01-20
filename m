Return-Path: <linux-kernel-owner+w=401wt.eu-S965125AbXATDyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbXATDyK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbXATDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:54:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57601 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965125AbXATDyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:54:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZK9vUo9NHubS1ApZ4L8UcEuCfbZwbxgOeFuyQ0FbCGyAcycG1V7OvXiKpB5jxBTv8+fDjoss0PfuaVWGSMkfs4Og3LBDCWY9jNMtdWRlSuIAd9/IO13ow1x7WUAprsdg3ZR44aq638yF/fdtn8dhdOOD3k4Si2q7MEUR8sOMo2U=
Message-ID: <8355959a0701191954g4c549a0eg916c1fcac219a566@mail.gmail.com>
Date: Sat, 20 Jan 2007 09:24:07 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: Missing dmesg parameters in 2.6.19.2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B1895F.1090206@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.fNZG37ToxSA055/pURYuraLOnPA@ifi.uio.no>
	 <45B1895F.1090206@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Robert Hancock <hancockr@shaw.ca> wrote:
> > 1) Compiling with SMP as Generic (CONFIG_X86_PC is not set, CONFIG_M686=y)
> >
> > ........
> > ........
> > Using x86 segment limits to approximate NX protection
> > ........
> > ........
> > Using APIC driver default
> > ........
> > ........
> >
> > 2) Compiling with SMP as Processor specific (CONFIG_X86_PC=y,
> > CONFIG_MPENTIUM4=y)
> >
> > I do not find the above mentioned parameters in this case.
>
> I don't think the "segment limits" message shows up in stock kernels,
> are you sure that was from 2.6.19.2? That sounds like a Fedora kernel
> with Exec Shield.
>
> --
> Robert Hancock      Saskatoon, SK, Canada

I am very sorry, have lost my mind with the night out with these
kernels (messed up).

Yep, you are right. Case 1 is FC6 kernel. Case 2 is my customization
with 2.6.19.2. I was thinking about APIC in Case 2....


~Akula2
