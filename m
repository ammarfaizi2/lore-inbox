Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314637AbSD0WrV>; Sat, 27 Apr 2002 18:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314638AbSD0WrU>; Sat, 27 Apr 2002 18:47:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4881 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314637AbSD0WrT>;
	Sat, 27 Apr 2002 18:47:19 -0400
Message-ID: <3CCB1BBA.9060609@evision-ventures.com>
Date: Sat, 27 Apr 2002 23:44:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.10-dj1 compilation failure
In-Reply-To: <20020427192459.P14743@suse.de> <Pine.LNX.4.44.0204271033010.5612-100000@k2-400.lameter.com> <20020427194728.Q14743@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Dave Jones napisa?:

> I debated adding this as a CONFIG_DEBUG_BROKEN_SCSI_DRIVERS or similar
> when Christoph first sent me the patch.  Given how many reports of
> "xxx being broken" I've had, I'm tempted to do that for -dj2.

Flagging them in the leading commant with somthing
along

/* XXX FIXME: please convert this to the new eh handling */

would be helpfull as well. It saves you the reversion of
the aformentioned config option.

