Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHMO4c>; Tue, 13 Aug 2002 10:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHMO4b>; Tue, 13 Aug 2002 10:56:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:20728 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315445AbSHMO4b>; Tue, 13 Aug 2002 10:56:31 -0400
Subject: Re: [patch] PCI Cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: colpatch@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
In-Reply-To: <1847016869.1029223059@[10.10.2.3]>
References: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk> 
	<1847016869.1029223059@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 15:57:48 +0100
Message-Id: <1029250668.22847.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 15:17, Martin J. Bligh wrote:
> Alan, please *look* at the patch. The NULL check is already
> there, he's REMOVING about 60 lines of duplicated code,
> reducing the complexity, and shifting the indirection up one
> level to get rid of redundancy.
> 
> If you want to delete the NULL check as well, that's fine, but
> totally a side issue. Ironically, the very snippet of code you
> quoted is all prefaced with "-", no?

I pointed out before the null check was flawed. And all I see is the
same identical patch churned out again. Regardless of whether that
paticular stupid error was in the old code, not fixing it in the new
code when its pointed out is a bit of a mess.

I'm not sure its a simplification either. More function pointers don't
always make for neater - but thats a side issue. If the NULL check goes
I'm not too worried about the other stuff.

