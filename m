Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbUKKKQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUKKKQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUKKKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:16:13 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:26830 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262087AbUKKKQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:16:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KrYlElWZGbM8VPsSZTzUP1DkT1TXbnfVTjaUMbpCNpznVwfLxoVHXReJWvnvaxE9JJPNyOGL47OJNv/ztXcmqW5fyzId8RXLgtCobUOfgXuBaw8hhMMca54Qu/Psg8895huM00wf82rH1advG87tVR1vEzXMYcuGBTzm4f/eVdk=
Message-ID: <21d7e99704111102166ce03312@mail.gmail.com>
Date: Thu, 11 Nov 2004 21:16:07 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: kconfig/build question..
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0411101253460.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0411100110170.1637@skynet>
	 <Pine.LNX.4.61.0411101253460.17266@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Do you really want to say that DRM can't be disabled if AGP is enabled?
> Otherwise this should do it:
> 
>         depends on AGP || AGP=n
> 

Thanks Roman, I think that is the solution I was looking for...

Dave.
