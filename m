Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSG3SGR>; Tue, 30 Jul 2002 14:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSG3SGR>; Tue, 30 Jul 2002 14:06:17 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23035 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316682AbSG3SGQ>; Tue, 30 Jul 2002 14:06:16 -0400
Date: Tue, 30 Jul 2002 14:09:39 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730140939.F10315@redhat.com>
References: <20020730125943.B10315@redhat.com> <200207301910.OAA03142@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207301910.OAA03142@ccure.karaya.com>; from jdike@karaya.com on Tue, Jul 30, 2002 at 02:10:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 02:10:35PM -0500, Jeff Dike wrote:
> We did come up with a scheme that sounded to me like it would work.

A constant address is still an option with an mmap'd device.  Just do 
an mmap of the device and assert that it is the correct value.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
