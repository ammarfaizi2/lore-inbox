Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288263AbSAHTeD>; Tue, 8 Jan 2002 14:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288260AbSAHTdx>; Tue, 8 Jan 2002 14:33:53 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:8098 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S288263AbSAHTdm>;
	Tue, 8 Jan 2002 14:33:42 -0500
Date: Tue, 8 Jan 2002 14:33:55 -0500
Subject: Re: Whizzy New Feature: Paged segmented memory
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: jtv <jtv@xs4all.nl>, Jacques Gelinas <jack@solucorp.qc.ca>,
        linux-kernel@vger.kernel.org
To: root@chaos.analogic.com
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <Pine.LNX.3.95.1020108090853.226A-100000@chaos.analogic.com>
Message-Id: <A7567F5E-046E-11D6-8467-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, January 8, 2002, at 09:14 AM, Richard B. Johnson wrote:

> At least with Intel ix8*, even though one can create a discriptor for
> a (backwards) stack, you would have a hard time using it. 
> 'Push' op-codes
> decrement the stack-pointer and 'pop' increments it regardless of
> the characteristics of the stack-selector.

You'd have to do it manually, without those instructions. That's 
what you get for using a CISC architecture from who-knows-when.

I'd guess most RISC architectures don't have this problem.

