Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267877AbRGRNWn>; Wed, 18 Jul 2001 09:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbRGRNWd>; Wed, 18 Jul 2001 09:22:33 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:22290 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S267874AbRGRNWQ>;
	Wed, 18 Jul 2001 09:22:16 -0400
Date: Wed, 18 Jul 2001 09:22:16 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc Linux-2.4.2 not generating core dump for SIGSEGV and abort()
Message-ID: <20010718092216.D16609@fury.csh.rit.edu>
In-Reply-To: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>; from mdaljeet@in.ibm.com on Wed, Jul 18, 2001 at 06:31:25PM +0530
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2001 at 06:31:25PM +0530, mdaljeet@in.ibm.com wrote:
> Hi all,
>      I am using Suse-linux-7.1 with default linux -ppc kernel on apple G4
> machine.
> SIGSEGV is never generating the core dump. though this signal is being
> caught by the user process.
> I also tried with "abort" call which should generate the core dump, but
> this is also not working. The same program with abort call is generating
> core dumps on other linux/unix platforms.
> Can anybody tell me where is the problem?

    Core dumps are disabled by default for a SuSE install.

    If you're using bash:
    ulimit -c unlimited

    or csh:
    unlimit coredumpsize

    -Jeff
-- 
Jeff Mahoney
jeffm@suse.com
jeffm@csh.rit.edu
