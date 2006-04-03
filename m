Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDCKbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDCKbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWDCKbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 06:31:21 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:37696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751163AbWDCKbV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 06:31:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nbKs8SQu2V5CBzQThCryt9axv+5RagrHIGRMGZPYNzSdT7paeVSFtMXD7u7p7HYOYsZttWmXiSjtmeMbfPD6mG7KrmwGOkHHmWTovCDWkwUvlox8Zo+G7dcaWQNhEdgl4uNLZSGu0u/o668Bbn6Wafy7V8y8oOVnWNIJKYzY0kU=
Message-ID: <d6944c490604030331s78ba93dap3496b10a08d81326@mail.gmail.com>
Date: Mon, 3 Apr 2006 12:31:20 +0200
From: "Dan Bar Dov" <bardov@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada7j6d89oz.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ada7j6f8xwi.fsf@cisco.com>
	 <d6944c490603290028n70725678g287445429a9c2ae5@mail.gmail.com>
	 <ada7j6d89oz.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the other hand, there are user-space consumers for CMA,
such as udapl, so although ISER will attempt only at 2.6.18,
maybe it is a good idea to get CMA into 2.6.17

Dan

On 3/29/06, Roland Dreier <rdreier@cisco.com> wrote:
>     Dan> Therefore the plan for iSER is to push it into 2.6.18
>
> OK, thanks.
>
> Based on all of this I'm thinking that it's better to hold back the
> RDMA CM as well, since there will be no code using it ready to merge
> for 2.6.17.
>
>  - R.
>
