Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTDIXRP (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTDIXRP (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:17:15 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:4487 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S263875AbTDIXRO (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 19:17:14 -0400
Date: Wed, 9 Apr 2003 16:27:15 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ?
Message-ID: <20030409232715.GE31739@ca-server1.us.oracle.com>
References: <20030409121537.36ba3fce.akpm@digeo.com> <200304092109.h39L9OV08801@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304092109.h39L9OV08801@verdi.et.tudelft.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 11:09:23PM +0200, Rob van Nieuwkerk wrote:
> But a friend of mine uses O_DIRECT with 2.4 kernels to read *individual*
> single harddisk sectors of 512 bytes !  He claims that my original
> theory is the right one and that you can read 512 byte chunks on 512
> byte bounderies (he uses the complete device eg. /dev/hda).

	Well, how does your friend access /dev/hda?  Is he using raw
devices?

Joel

-- 

"What do you take me for, an idiot?"  
        - General Charles de Gaulle, when a journalist asked him
          if he was happy.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
