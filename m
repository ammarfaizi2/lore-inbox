Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267063AbTGOKHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbTGOKHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:07:33 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:45738 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S267063AbTGOKH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:07:29 -0400
To: linux-kernel@vger.kernel.org
From: junkio@cox.net
Subject: Re: "Where's the Beep?" (PCMCIA/vt_ioctl-s)
References: <fa.hjqfgl8.17m6f00@ifi.uio.no> <fa.h26ngau.73iiag@ifi.uio.no>
Date: Tue, 15 Jul 2003 03:22:18 -0700
In-Reply-To: <fa.h26ngau.73iiag@ifi.uio.no> (Neil Brown's message of "Tue,
 15 Jul 2003 07:56:07 GMT")
Message-ID: <7vwueknl7p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "NB" == Neil Brown <neilb@cse.unsw.edu.au> writes:

NB> On Tuesday July 15, bde@nwlink.com wrote:

>> On my old DELL LM laptop the -2.5 series no longer issues any beeps when
>> a card is inserted.  The problem is in the kernel, as the test program
>> below (extracted from cardmgr) beeps on -2.4, but not on -2.5.

NB> CONFIG_INPUT_PCSPKR
NB> needs to be =y or =m and the module loaded.

That's true, but I wonder why PC Speaker is under *INPUT*
category...

