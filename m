Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbVIPILv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbVIPILv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVIPILv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:11:51 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:46656 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161065AbVIPILu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:11:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P91Eo5+v/8vbvbwGpgoXq1Wu9ey3NZ9cO2h2bDS1ilqY65XhjjkQAn2UHmXXxtf1kaak1HpsMTIxpFpgillxejAnUDHgK46erlS/NpgBTTH/hLb9d0VBbCTJLhiJcdGXpr3p048zeeyzp7GoshBCkrVtW3BJOTJPpQwoDH5Wi3c=
Message-ID: <2cd57c9005091601112e215a1e@mail.gmail.com>
Date: Fri, 16 Sep 2005 16:11:44 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> Hi
> 
> I wrote this Framework for making a .config based on
> the System Hardwares. It would be a great help if some
> people would give me their opinion about it.
> 
> Regards
> 
> A.R.Cheraghi
> 

How about the idea that we have a .hwconfig file and we do `make
hwconfig' to generate it? So normal filesystems and network stack
stuff don't belong to hwconfig.

.hwconfig file merely stores the result from auto hardware detection.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
