Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288007AbSAQHtD>; Thu, 17 Jan 2002 02:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288266AbSAQHsx>; Thu, 17 Jan 2002 02:48:53 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:46605 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288007AbSAQHsl>;
	Thu, 17 Jan 2002 02:48:41 -0500
Date: Thu, 17 Jan 2002 18:47:16 +1100
From: Anton Blanchard <anton@samba.org>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: Barry Wu <wqb123@yahoo.com>,
        Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how many cpus can linux support for SMP?
Message-ID: <20020117074715.GA8869@krispykreme>
In-Reply-To: <20020117065841Z288225-13996+7386@vger.kernel.org> <1011252982.5188.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011252982.5188.5.camel@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> there is a 32bit cpu mask, meaning 32 is the absolute max, although Ralf
> Baechle has extended it to 64 in order to support SGI origin 2000's, but
> realistically, linux can only do about 8 before falling on the ground...

Its actually the number of bits in a long so 64 bit archs can boot 64
cpus. I think Kanoj had a hack to do a 128 cpu boot on SGI hardware.

Anton
