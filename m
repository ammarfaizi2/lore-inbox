Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTBKVNS>; Tue, 11 Feb 2003 16:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBKVNR>; Tue, 11 Feb 2003 16:13:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32012 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266443AbTBKVNQ>; Tue, 11 Feb 2003 16:13:16 -0500
Date: Tue, 11 Feb 2003 21:23:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Murphy <brian@murphy.dk>, linux-kernel@vger.kernel.org
Subject: Re: mtdblock read only device broken?
Message-ID: <20030211212301.C24592@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Brian Murphy <brian@murphy.dk>, linux-kernel@vger.kernel.org
References: <3E48080F.9060209@murphy.dk> <1044978975.2263.28.camel@passion.cambridge.redhat.com> <3E49366E.10508@murphy.dk> <1044994408.7004.1.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044994408.7004.1.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Tue, Feb 11, 2003 at 08:13:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:13:28PM +0000, David Woodhouse wrote:
> I'm not entirely convinced the block device drivers work in 2.5 at the
> moment. I was holding off on fixing them up, to let the 2.5 code
> actually settle down, and to see if those who changed the core code
> would fix up the drivers accordingly. My merge from Linus' tree recently
> was more focussed on things which were relevant for a merge to 2.4,
> rather than merging back to Linus -- that's my next task.

mtdblock / mtdblock_ro should be fine; I haven't had problems with them
here in 2.5.60.  Do you have any specific concerns about these two?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

