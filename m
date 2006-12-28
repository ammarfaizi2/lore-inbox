Return-Path: <linux-kernel-owner+w=401wt.eu-S1754865AbWL1PTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbWL1PTj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754869AbWL1PTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:19:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:1542 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbWL1PTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:19:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SETOIKMdbXo4WBXqT6rUV7YesOc/VUYvmk+JvwglWr7bDUYnJ5XKZBdKFnQbJ1qYVpxoa4cDC+SxirNfm88cDmnI0ycGYEIq+SgnYUX358ozW8WVM90LxkhpByEiAJdngDg9WFx0/QlfWZkmw+eOFzsiVpSm4VNIhBGBaGaCMoM=
Message-ID: <75b57c110612280719x6627a5f7saf9d4b707ffff78d@mail.gmail.com>
Date: Thu, 28 Dec 2006 10:19:37 -0500
From: "Gerb Stralko" <gerb.stralko@gmail.com>
To: "Yu-Chen Wu" <g944370@oz.nthu.edu.tw>
Subject: Re: How to get the processor ID at run-time?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001301c72a8e$f411ac30$0100a8c0@sslabmayasky>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <001301c72a8e$f411ac30$0100a8c0@sslabmayasky>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I am writing a kernel module that creates a kernel thread on a SMP
>platform.
>How to get the ID of the processor the kernel thread run on? Have any
>kernel API?   THX
>Raymond

try  smp_processor_id() it returns an unsigned int.

Thanks,

jerry
