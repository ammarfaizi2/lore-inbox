Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286153AbRLTF6b>; Thu, 20 Dec 2001 00:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286148AbRLTF6W>; Thu, 20 Dec 2001 00:58:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286150AbRLTF6K>; Thu, 20 Dec 2001 00:58:10 -0500
Message-ID: <3C217DE5.5050104@zytor.com>
Date: Wed, 19 Dec 2001 21:57:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - 32-bit IO support
In-Reply-To: <20011218235024.N13126@flint.arm.linux.org.uk>	<9vrmea$mef$1@cesium.transmeta.com> <20011219.213019.35013739.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date: 19 Dec 2001 19:37:46 -0800
>    
>    You probably need to verify that 32-bit support is available (both on
>    the bridge and the peripherals), but if they are, there's no reason
>    not to use it on non-x86 architectures...
> 
> Don't the PCI specs actually talk about 24-bits in fact?
> 


No.  IOIO is 32 bits on PCI; however, it is legal to hardwire the top 16 
bits to zero.  It's something like 26 bits on HyperTransport.

	-hpa


