Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSGVCJr>; Sun, 21 Jul 2002 22:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGVCJr>; Sun, 21 Jul 2002 22:09:47 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:30937 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S315491AbSGVCJr>; Sun, 21 Jul 2002 22:09:47 -0400
Message-ID: <3D3B6A5F.1010608@snapgear.com>
Date: Mon, 22 Jul 2002 12:13:51 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE]: linux-2.5.27uc0 MMU-less patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Latest uClinux (MMU-less) patches up at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.27uc0.patch.gz

I had to do a little hacking around the reverse mapping.
Probably needs more testing, but seems to work ok for now.

Still tracking down an existing problem where the mmnommu
page_alloc is occassionaly giving out a memory address as
free memory that is really in use...

Evertyhing else seems to work well (at least on the 5272 ColdFire
target board that I have tested on!)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

