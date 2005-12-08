Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLHJWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLHJWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVLHJWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:22:42 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:5832 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750921AbVLHJWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:22:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IAzDTypWRgPo0JJ6/+0aTeCiymqeDQSZoHXgLSFT5pRTUco9W4QS1xVPuTnmRR4WEA1UgZNL9XG/X7asch2wtVyvD5JZT9U1byqGq7DCO06GkI8FDaf2B1yetG/N4OPm/yOH5WeTy4/8mht0z7nusBEaWmCtERKcRHqq+8g4kH8=
Message-ID: <2cd57c900512080122s74c2f9v@mail.gmail.com>
Date: Thu, 8 Dec 2005 17:22:40 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: yen <yen@eos.cs.nthu.edu.tw>
Subject: Re: IRQ vector assignment for system call exception
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051208080435.M54890@eos.cs.nthu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051208080435.M54890@eos.cs.nthu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/8, yen <yen@eos.cs.nthu.edu.tw>:
> Hi:
>    I have a quwstion. Why the number 128 is reserver for system call exception in
> interrupt vectors? Why not other numbers? Are there any historical reasons?
> thanks.
>

0x80 stands in the middle of [0..0xff].
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
