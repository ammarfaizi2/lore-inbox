Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318390AbSGRVmV>; Thu, 18 Jul 2002 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318391AbSGRVmV>; Thu, 18 Jul 2002 17:42:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2572 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318390AbSGRVmU>;
	Thu, 18 Jul 2002 17:42:20 -0400
Date: Thu, 18 Jul 2002 22:45:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Matthew Wilcox <willy@debian.org>, jsimmons@transvirtual.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718224521.R13352@parcelfarce.linux.theplanet.co.uk>
References: <B48C1CD735C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B48C1CD735C@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 18, 2002 at 11:42:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:42:18PM +0200, Petr Vandrovec wrote:
> CONFIG_VGA_CONSOLE/CONFIG_DUMMY_CONSOLE determines whether your VT can
> be created at all - maybe _CONSOLE suffix is misleading - without
> having at least one displaying device virtual terminals cannot be build.
> I always thought that CONFIG_DUMMY_CONSOLE cannot be unset, but
> apparently it can...
> 
> And BTW, when such configuration worked for you last time? It does not
> look to me like that it should ever work.

erm, 2.5.25 worked, and i didn't change the .config between 2.5.25 and
2.5.26 (just ran make oldconfig).

-- 
Revolutions do not require corporate support.
