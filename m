Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbUK3XSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUK3XSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUK3XPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:15:11 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24705 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262437AbUK3XLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:11:01 -0500
Message-ID: <41ACFDAF.3040209@nortelnetworks.com>
Date: Tue, 30 Nov 2004 17:09:35 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org> <20041130225128.GA31216@infradead.org>
In-Reply-To: <20041130225128.GA31216@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>b) when include/user is deemed sufficiently populated, a flag day is
>>declared and links from /usr/include are switched to them
> 
> 
> there are no such links, only copies (more or less modified)

This may be somewhat heretical, but someone has to ask...

Once include/user/foo.h is sufficiently clean and sufficiently complete, is 
there any reason to not allow such links?

Chris
