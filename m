Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTJOSCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTJOSCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:02:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:27008 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263857AbTJOSCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:02:21 -0400
Date: Wed, 15 Oct 2003 20:02:06 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: san_madhav@hotmail.com
Cc: inaky.perez-gonzalez@intel.com, Tim Hockin <thockin@hockin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Question on atomic_inc/dec
Message-ID: <20031015180206.GA7250@vana.vc.cvut.cz>
References: <A20D5638D741DD4DBAAB80A95012C0AED7868F@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AED7868F@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 10:38:14AM -0700, Perez-Gonzalez, Inaky wrote:
> > From: sankar [mailto:san_madhav@hotmail.com]
> 
> >  any solution to the original problem???
> > (atomic_inc() defintion not there in redhat 9.0 asm/atomic.h)
> 
> Create an atomic.h header file in your source tree with the code
> below, but bear in mind that porting to other arches might be painful:

It is OT, but if you are interested, take a look at include/private/*atomic*,
include/private/*/*atomic* and relevant portions (ncphost) of configure.ac 
in the ncpfs package (http://platan.vc.cvut.cz/ftp/pub/linux/ncpfs/ncpfs-2.2.3.tar.gz).

It contains UP, pthread based, and several asm optimized versions of
atomic ops. I'm not 100% sure that all asm versions work correctly,
but I have received no complaints yet...
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

