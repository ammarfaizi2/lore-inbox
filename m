Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTLYSNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 13:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTLYSNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 13:13:25 -0500
Received: from [195.62.234.69] ([195.62.234.69]:31646 "EHLO
	mail.nectarine.info") by vger.kernel.org with ESMTP id S264337AbTLYSNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 13:13:24 -0500
Message-ID: <3FEB28F1.80305@nectarine.info>
Date: Thu, 25 Dec 2003 19:14:09 +0100
From: Giacomo Di Ciocco <admin@nectarine.info>
Organization: Nectarine Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe.korty@ccur.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: 2.6.0 "Losing too many ticks!"
References: <1072321519.1742.328.camel@cube> <20031225161748.GA31564@tsunami.ccur.com>
In-Reply-To: <20031225161748.GA31564@tsunami.ccur.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:

 > Or maybe IDE DMA is disabled. That would account for lost
 > ticks during period of heavy disk IO.  Giacomo, type
 >
 >   hdparm /dev/hda
 >
 > If it shows 'using DMA' off, try
 >
 >   hdparm -d1 /dev/hda
 >
 > If that fails then the IDE driver you need is not
 > configured in your kernel.
 >
 > Joe

Hi Joe,
enabling the dma mode has resolved the "Losing too many ticks" thing, now the
system seems running fine, the unique strange thing is the "Unknown HZ value!
(92) Assume 100." message, that appears before the output of any program launched.

Thanks everyone for the support.

Regards.

-- 
Giacomo Di Ciocco
Nectarine Administrator
Phone/Fax: (+39) 577663107
Web: http://www.nectarine.info
Irc: irc.nectarine.info #nectarine
Email: admin@nectarine.info (pgp.mit.edu)
