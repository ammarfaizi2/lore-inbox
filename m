Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTLCN2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbTLCN2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:28:52 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:9476 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S264571AbTLCN2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:28:50 -0500
Message-ID: <3FCDE506.7020302@free.fr>
Date: Wed, 03 Dec 2003 14:28:38 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Mike Fedyk <mfedyk@matchmail.com>, zwane@zwane.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
References: <3FC4DA17.4000608@free.fr>	<Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>	<3FC4E42A.40906@free.fr>	<Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>	<3FC4E8C8.4070902@free.fr>	<Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>	<20031126233738.GD1566@mis-mike-wstn.matchmail.com>	<3FC53A3B.50601@free.fr>	<20031202160303.2af39da0.rddunlap@osdl.org>	<20031203003106.GF4154@mis-mike-wstn.matchmail.com> <20031202162745.40c99509.rddunlap@osdl.org>
In-Reply-To: <20031202162745.40c99509.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 2 Dec 2003 16:31:06 -0800 Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> | On Tue, Dec 02, 2003 at 04:03:03PM -0800, Randy.Dunlap wrote:
> | > On Thu, 27 Nov 2003 00:41:47 +0100 Vince <fuzzy77@free.fr> wrote:
> | > 
> | > | Mike Fedyk wrote:
> | > | > Interesting.  It would be nice to have a boot option that halts the system
> | > | > after the first oops, instead of trying to continue.
> | > 
> | > You mean like the "panic_on_oops" sysctl??  (implemented in i386 & ppc64)
> | 
> | ...
> | 
> | Wouldn't he only get the first oops on the diskette if he had the sysctl
> | mentioned above enabled?
> 
> Yes, I think that you are right.
> 

Well, I get indeed a nice oops on screen with this sysctl... but the 
oops/panic does not appear on the floppy dump  :-/

--------------------------------------------------------
<0>Kernel panic: Fatal exception
<4> <0>Dumping messages in 100 seconds : last chance for 
Alt-SysRq...<6>SysRq :
Emergency Sync
<6>SysRq : Emergency Sync
<6>SysRq : Emergency Remount R/O
<6>SysRq : Trying to dump through real mode
<4>
---------------------------------------------------------

