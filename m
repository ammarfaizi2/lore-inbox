Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285180AbRLSJgo>; Wed, 19 Dec 2001 04:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284911AbRLSJgh>; Wed, 19 Dec 2001 04:36:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284946AbRLSJgQ>; Wed, 19 Dec 2001 04:36:16 -0500
Message-ID: <3C205FBC.60307@zytor.com>
Date: Wed, 19 Dec 2001 01:37:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Christian Koenig <ChristianK.@t-online.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        antirez <antirez@invece.org>, Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>	<m1r8prwuv7.fsf@frodo.biederman.org> <3C204282.3000504@zytor.com>	<m1itb3wsld.fsf@frodo.biederman.org> <3C2052C0.2010700@zytor.com> <m18zbzwp34.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>>From the 10,000 foot level it looks like I am pretty safe already
> except for those BIOS functions that drive the hardware.  For those I
> need to setup the legacy PIC back to it's default setting, and
> possibly a few other hardware things.   I wonder just how sensitive
> the an x86 BIOS really is to changing those things...
> 

You never know, especially since part of the BIOS might be an external 
SCSI or network card BIOS...

	-hpa

