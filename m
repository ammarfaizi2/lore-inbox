Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRI0Ca7>; Wed, 26 Sep 2001 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRI0Caj>; Wed, 26 Sep 2001 22:30:39 -0400
Received: from zok.sgi.com ([204.94.215.101]:30178 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275739AbRI0Cag>;
	Wed, 26 Sep 2001 22:30:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff) 
In-Reply-To: Your message of "Wed, 26 Sep 2001 17:54:52 EST."
             <Pine.LNX.4.33.0109261740500.26001-200000@ping.us.dell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Sep 2001 12:30:53 +1000
Message-ID: <8263.1001557853@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 17:54:52 -0500 (CDT), 
Robert Macaulay <robert_macaulay@dell.com> wrote:

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          D F7108AA0     0     1      0   754       3       (NOTLB)
Call Trace: [<c0139df6>] [<c013d4bb>] [<c013d693>] [<c01ddf79>] [<c0131751>] 
   [<c0131b29>] [<c0131b7e>] [<c013257e>] [<c013284c>] [<c0132950>] [<c01494b3>] 
   [<c01440e9>] [<c0149717>] [<c0149b99>] [<c010710b>] 

Run that through ksymoops version >= 2.4.2, it decodes sysrq-T output.

