Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSDWIeI>; Tue, 23 Apr 2002 04:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315113AbSDWIeH>; Tue, 23 Apr 2002 04:34:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62689 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315111AbSDWIeG>;
	Tue, 23 Apr 2002 04:34:06 -0400
Date: Tue, 23 Apr 2002 01:14:32 -0700 (PDT)
Message-Id: <20020423.011432.86512016.davem@redhat.com>
To: paulus@samba.org
Cc: peterson@austin.ibm.com, anton@au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15557.5295.921549.964163@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Tue, 23 Apr 2002 18:00:47 +1000 (EST)
   
   Doesn't the fact that people have been successfully using PCI devices
   in PowerPC machines since 1995 or 1996 suggest to you that it might be
   your understanding that is faulty rather than the code? :)

And sparc64 :-)

An important point to mention is that big endian systems need to do
byte twisting in the PCI controller for all the byte-lane issues to
work out properly.

Maybe this guys box has a broken PCI host bridge implementation that
doesn't do the byte-twisting and we should consider that in our
analysis of his problems :-)
