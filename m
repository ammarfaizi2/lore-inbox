Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCHURu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUCHURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:17:50 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:49081 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261187AbUCHURs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:17:48 -0500
Message-ID: <404CD4E7.5050105@uni-paderborn.de>
Date: Mon, 08 Mar 2004 21:17:43 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <404C4D32.1080609@uni-paderborn.de> <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de>
In-Reply-To: <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert schrieb:
> On Monday 08 March 2004 11:38, Bjoern Schmidt wrote:
> 
>>Hello,
>>is there a way to measure/change the fsb of a PII/233/Tonga/440BX while
>>running linux? Google has no answer...
> 
> 
> This is the only one I know about, but it has support for a few boards/pll's 
> only.
> 
> http://home.iprimus.com.au/mccvals/mvpll/
> 
> Hope it helps,
> 	Bernd

Hello and thank you for your answer. I determined that this cpu has a fsb of
66MHz. The reason for my question was that i want to underclock the cpu.
I think it would be better to change the multiplier instead of changing the fsb.
Therefore i read the msr register 0x02ah, tilted bit 27 and wrote it back, but
the cpu clock is still the same. Why does that not work? Is it possible to
change the multiplier at runtime at all?

-- 
Mit freundlichen Gruessen
Bjoern Schmidt


