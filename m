Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291836AbSBHVMf>; Fri, 8 Feb 2002 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291818AbSBHVMQ>; Fri, 8 Feb 2002 16:12:16 -0500
Received: from holomorphy.com ([216.36.33.161]:55443 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291813AbSBHVMJ>;
	Fri, 8 Feb 2002 16:12:09 -0500
Date: Fri, 8 Feb 2002 13:11:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Balbir Singh <balbir_soni@hotmail.com>
Cc: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
Message-ID: <20020208211151.GD767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Balbir Singh <balbir_soni@hotmail.com>, tigran@veritas.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <F39q2pNdXfH4Ryzp5fO0000a02b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <F39q2pNdXfH4Ryzp5fO0000a02b@hotmail.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 12:42:02PM -0800, Balbir Singh wrote:
> It is highly recommended to use the existing stack size of
> 8KB, increasing the stack size to 16KB with an 200
> processes running on an average causes 1.5MB of
> extra memory to be used.

This sounds small compared to the costs of struct page.
Of course, I would be concerned regardless if this patch
were for anything but debugging.

Excellent work!


Cheers,
Bill
