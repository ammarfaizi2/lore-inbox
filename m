Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292989AbSCAP6e>; Fri, 1 Mar 2002 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292507AbSCAP6Y>; Fri, 1 Mar 2002 10:58:24 -0500
Received: from sebula.traumatized.org ([193.121.72.130]:41665 "EHLO
	sebula.traumatized.org") by vger.kernel.org with ESMTP
	id <S293005AbSCAP6H>; Fri, 1 Mar 2002 10:58:07 -0500
X-NoSPAM: http://traumatized.org/nospam/
Message-ID: <3C7F93FE.5020602@pophost.eunet.be>
Date: Fri, 01 Mar 2002 15:45:18 +0100
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:0.9.8) Gecko/20020220
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.19pre2 - USB - sparc64 compile problem
In-Reply-To: <3C7F8B80.1010007@pophost.eunet.be> <20020301.073142.24904941.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>    hcd.c: In function `usb_hcd_pci_probe':
>    hcd.c:627: `irq' undeclared (first use in this function)
>    hcd.c:627: (Each undeclared identifier is reported only once
>    hcd.c:627: for each function it appears in.)
> 
> Go to line 627 in an editor and change "irq" to be "dev->irq"
> 
> The same build failure got introduced when this code was merged
> into the 2.5.x tree and I had to fix it there too.

thanks, it compiles nicely now.


Jurgen.

