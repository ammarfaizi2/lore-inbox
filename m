Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbTC0Ifb>; Thu, 27 Mar 2003 03:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261816AbTC0Ifb>; Thu, 27 Mar 2003 03:35:31 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:21258 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261812AbTC0Ifa>; Thu, 27 Mar 2003 03:35:30 -0500
Date: Thu, 27 Mar 2003 08:46:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
Message-ID: <20030327084642.B29788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20030326163014$65d6@gated-at.bofh.it> <20030326201008$0568@gated-at.bofh.it> <200303262350.h2QNoqjd015366@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303262350.h2QNoqjd015366@post.webmailer.de>; from arnd@bergmann-dalldorf.de on Wed, Mar 26, 2003 at 11:44:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 11:44:51PM +0100, Arnd Bergmann wrote:
> > Now actually take a look at this diff :)  The biggest part is that the
> > s390 compat files exist only on s390x and the math-emu dir only exists
> > on s390, that's just a matter of conditionally compiling the files.
> 
> I agree that it would be nice to do this merge and that it can be done
> without introducing much ugliness. However, removing a whole arch
> tree would be a major change considering that we are in the middle
> of what is supposed to be a feature freeze.

I don't think feature freeze matters for architeture-dependen code. If IBM
thinks this can be done without disturbing their plans for 2.6-based
production releases (and I couldn't see why it would), then it's okay.

