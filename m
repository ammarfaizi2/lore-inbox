Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHFQcB>; Tue, 6 Aug 2002 12:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSHFQcB>; Tue, 6 Aug 2002 12:32:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:13042 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313181AbSHFQcA>; Tue, 6 Aug 2002 12:32:00 -0400
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
In-Reply-To: <1245189818.1028621171@[10.10.2.3]>
References: <1028649942.18130.172.camel@irongate.swansea.linux.org.uk> 
	<1245189818.1028621171@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 18:54:31 +0100
Message-Id: <1028656471.18156.179.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 16:06, Martin J. Bligh wrote:
> The STANDALONE thing? I'm not convinced that's really any cleaner,
> it makes even more of a mess of io.h than there was already (though
> we could consider that a lost cause ;-)). 
> 
> What's your objection to just throwing in a defn of xquad_portio?
> A preference for burying the messy stuff in header files? Seems to
> me that as you have to define STANDALONE now, the point is moot.

Because you are assuming there will be -one- kind of wackomatic PC
system - IBM's. The chances are there will be more than one as other
vendors like HP, Compaq and Dell begin shipping stuff. Having
__STANDALONE__ works for all the cases instead of exporting xquad this
hpmagic that and compaq the other in an ever growing cess pit

