Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284495AbRLRSbN>; Tue, 18 Dec 2001 13:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284480AbRLRSbD>; Tue, 18 Dec 2001 13:31:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33554 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284479AbRLRSar>; Tue, 18 Dec 2001 13:30:47 -0500
Message-ID: <3C1F8BB4.6070001@zytor.com>
Date: Tue, 18 Dec 2001 10:32:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Christian Koenig <ChristianK.@t-online.de>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        antirez <antirez@invece.org>, Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7FE@orsmsx111.jf.intel.com> <16GLAZ-1rFguGC@fwd07.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Koenig wrote:
> 
> I agree, but the problem I have with Initrd is that you could only have 
> 1 single initrd-image on your hard disk / loaded by the boot-loader.
> 

Al and I have already discussed an improved approach.  What we want is 
rather than initrd an initramfs.  I have specifically discussed the 
initramfs protocol with Al so it can be combined from multiple sources.

	-hpa

