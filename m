Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbTCGLt6>; Fri, 7 Mar 2003 06:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbTCGLt6>; Fri, 7 Mar 2003 06:49:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45993
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261517AbTCGLt5>; Fri, 7 Mar 2003 06:49:57 -0500
Subject: Re: Disabling ATAPI retry?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Pittman <daniel@rimspace.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87k7fbq0nx.fsf@enki.rimspace.net>
References: <3e67c49b.7c12.1804289383@wideopenwest.com>
	 <1046991672.17715.134.camel@irongate.swansea.linux.org.uk>
	 <87k7fbq0nx.fsf@enki.rimspace.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047042366.20793.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 13:06:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 04:08, Daniel Pittman wrote:
> On 06 Mar 2003, Alan Cox wrote:
> > On Thu, 2003-03-06 at 20:58, kelleycook@wideopenwest.com wrote:
> >> Is there a boot parameter or a runtime command that can tell
> >> the linux IDE driver not to automatically retry on error.
> > 
> > There isn't. You can always build a kernel set not to, but even then
> > it takes the drive firmware a sizeable time to retry a block. 
> 
> Hrm. Is this something that is likely to be introduced at some point?

I take patches. Otherwise its not going to happen until the bugs are
all sorted in 2.4 and 2.5, the current chipset stuff is all dealt with,
the initialisation mess is resolved, ide-cs unload bugs are fixed and
so on.

Alan

