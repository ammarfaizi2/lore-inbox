Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSAQHjx>; Thu, 17 Jan 2002 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAQHjk>; Thu, 17 Jan 2002 02:39:40 -0500
Received: from dsl-64-130-65-177.telocity.com ([64.130.65.177]:7161 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288262AbSAQHid>; Thu, 17 Jan 2002 02:38:33 -0500
Subject: Re: how many cpus can linux support for SMP?
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Barry Wu <wqb123@yahoo.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117065841Z288225-13996+7386@vger.kernel.org>
In-Reply-To: <20020117065841Z288225-13996+7386@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 23:36:19 -0800
Message-Id: <1011252982.5188.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 22:59, Barry Wu wrote:
> Hi, all,
> 
> I am new to this mail list. I do not know how many CPUs linux can
> support well using SMP. If some one knows, please give me
> a reply. Thanks.

there is a 32bit cpu mask, meaning 32 is the absolute max, although Ralf
Baechle has extended it to 64 in order to support SGI origin 2000's, but
realistically, linux can only do about 8 before falling on the ground...

depends on your workload really...you should be ok with 4 cpus.

-tduffy

