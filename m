Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271808AbRILVpY>; Wed, 12 Sep 2001 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271795AbRILVpP>; Wed, 12 Sep 2001 17:45:15 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:25092 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S271820AbRILVpE>;
	Wed, 12 Sep 2001 17:45:04 -0400
Message-ID: <20010912004818.A10240@bug.ucw.cz>
Date: Wed, 12 Sep 2001 00:48:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Rik van Riel'" <riel@conectiva.com.br>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Samium Gromoff'" <_deepfire@mail.ru>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>; from Grover, Andrew on Tue, Sep 04, 2001 at 02:52:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's Linux:
> 
> Drivers (SMP agnostic)
> Kernel (SMP/UP specific)
> 
> Here's Windows:
> 
> Drivers (SMP agnostic)
> Kernel (SMP agnostic)
> HAL (SMP/UP specific, contains locking primitive funcs etc.)
> 
> So they use the same kernel and just switch out the HAL.

-> overhead.

If you don't care about overhead, just run SMP kernels even on UP.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
