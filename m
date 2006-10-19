Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423308AbWJSLhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423308AbWJSLhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423309AbWJSLhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:37:43 -0400
Received: from [195.171.73.133] ([195.171.73.133]:1476 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1423308AbWJSLhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:37:42 -0400
Date: Thu, 19 Oct 2006 11:37:42 +0000
From: andrew@walrond.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make headers_install headers problem on sparc64
Message-ID: <20061019113742.GE17882@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com> <20061019105441.GC17882@pelagius.h-e-r-e-s-y.com> <20061019111037.GD17882@pelagius.h-e-r-e-s-y.com> <1161257672.3428.3.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161257672.3428.3.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 12:34:32PM +0100, David Woodhouse wrote:
> 
> No. That header should not be exposed to userspace. Just fix
> reiserfsprogs instead. It's not as if unaligned access is _hard_ -- you
> just have to ask the compiler to do it for you:
> 
> http://cvs.fedora.redhat.com/viewcvs/rpms/reiserfs-utils/devel/header-fix.patch?view=markup
> 
Thanks for the link

Andrew
