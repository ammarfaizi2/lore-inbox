Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752440AbWJ0UIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbWJ0UIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbWJ0UIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:08:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59938 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752440AbWJ0UIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:08:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aMj07C4gxIUban8D79540n/EZMhjZivUrNHUQDA5Fv0Kt9MWvWYWUYz4CBZuSyML/+weQafc69lozMZcqGlgo8LYNjLALQxynH+/8iKwKjbCwdSAoU2iiqw8QTsi80Vc8pmlB5/DgjYJos72HyHfwSeLWSDxnOxJTWVg0TwrAWs=
Message-ID: <cda58cb80610271308v137a2de8vfb8123a422270144@mail.gmail.com>
Date: Fri, 27 Oct 2006 22:08:47 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
	 <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
	 <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> No way. Each controller would have different wirings, pins, in-outs,
> specifications (...) You will need to code an almost whole new fbdev
> driver (althought maybe it will be so similar to cfag12864b so you
> only need to make few little changes, but that is unsure).
>

that's what I was trying to point out. I was wondering if you could
make your driver a little more generic so another lcd could use your
driver as is.

> Well, you were right about mmaping, but you weren't about
> "info->fix.smem_start". smem_start expects a physical address. RAM
> addresses can't be mmapped as usual

Sorry I don't understand your last sentence. Can you explain please ?

-- 
               Franck
