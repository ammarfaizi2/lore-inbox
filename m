Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWJWM46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWJWM46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWJWM46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:56:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26201 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964791AbWJWM45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:56:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PWsyQ9yxTTroerNlWGAYWqpxtI6eWzatfuRyFFmanYNlnwHRvHnvfXAsI71zylLf7OCPG6/VMX/vEWs3zR+L3nIuX7QOd3zJT4r3+XGet/SSIJTdrmNFX0e53wdzqq6CsAMceikIla7Og3eAalaElw485F7mRG9oYIE+OVgBVwc=
Message-ID: <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
Date: Mon, 23 Oct 2006 14:56:56 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <453C8027.2000303@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Franck Bui-Huu wrote:
> > Hi
> >
> >
> > sorry for coming lately, I just noticed your patch in -mm tree.
> >
> > Did you took a look at drivers/video/arcfb.c driver ?
> > It seems to be a fb driver for ks108 lcd controller. A lot of code
> > is related to the platform though and the controller is driven
> > through GPIO but have you tried to split the code for sharing
> > controller specific code. Note, I don't say it's a good idea, it's
> > just a question that comes in mind.
> >
> > Also you create driver/auxdisplay directory whereas drivers such
> > the one I mentioned previously is located in drivers/video. Why
> > not putting your driver in driver/video ?
>
> Is this driver is already no more maintained ?
>

The driver is waiting in the -mm tree (-mm2 right now) for being
included in the mainline kernel sometime in the future. If it is
included, I will maintain it as I coded it as it apears in the
MAINTAINERS file. Why are you so worried about it if I can ask? Do you
want some more features or something like that?

I missed the other two questions you wrote few days ago. About the
second one, that was discussed a lot in the past and the people
decided that (it wasn't my idea). About the first one, well, my ks0108
code is the one for the wiring of an auxiliary LCD, so if you read the
discussion you will find the people wanted to split video things and
other auxiliary displays, so I think it is better to split it.
(Anyway, I'm answering quickly, I haven't checked the code you talk
about, but I will anyway).

Thanks,
     Miguel Ojeda
