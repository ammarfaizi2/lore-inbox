Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSHGFlx>; Wed, 7 Aug 2002 01:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSHGFlw>; Wed, 7 Aug 2002 01:41:52 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:21236 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S317176AbSHGFlw>; Wed, 7 Aug 2002 01:41:52 -0400
Message-ID: <3D50B42B.8000200@snapgear.com>
Date: Wed, 07 Aug 2002 15:46:19 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Amol Lad <dal_loma@yahoo.com>
Subject: Re: uclinux on MMU platforms - query
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amol,

Amol Lad <dal_loma@yahoo.com> writes:
 > Hi,
 >  Can I run uClinux on platforms that has MMU

You could, but why would you want to?

If your processor has VM then wou will be better of
using it. Without VM you suffer more problems from
free memory fragmentation, no dynamically growing
stacks, ne memory protection between kernel and
processes, etc.

There are currently no patches for processors with
VM to run with the CONFIG_NO_MMU support of uClinux.
(There would be a little bit of work to do if you
wanted to).

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

