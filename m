Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423333AbWJaOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423333AbWJaOMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423340AbWJaOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:12:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:12187 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423333AbWJaOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:12:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F9CHNputhToAxIUv6JhDfY+GEsUpJmkg1jB8NWfDz/r44/7v62y+dyfISsF936iNTIJlCx708sbGbOQ+InsE3vXSG8+gsTTMlD7X4YbVRmAn0p9Y3q3V/MTUA/lTHWCJ9RrvP4BVmVsWEKYo3XjOHQL+aeSSlB62QiyJvmW1T8Y=
Message-ID: <653402b90610310612l2a2a07du91fd6d0bc6f2477a@mail.gmail.com>
Date: Tue, 31 Oct 2006 15:12:31 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: "Paulo Marques" <pmarques@grupopie.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <45470513.4070507@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
	 <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com>
	 <45470513.4070507@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Paulo Marques wrote:
>
> starting the refresh stuff _only_ when the device is
> mmaped seems to me a good trade off.
>

Well, if someone writes to /dev/fbX the LCD won't get updated. We
would need also to start/stop at the write/release fbfops as well. Let
me check.
