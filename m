Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGZEwc>; Fri, 26 Jul 2002 00:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSGZEwA>; Fri, 26 Jul 2002 00:52:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:64517 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316792AbSGZEub>; Fri, 26 Jul 2002 00:50:31 -0400
Message-ID: <3D40B0C0.9070708@evision.ag>
Date: Fri, 26 Jul 2002 04:15:28 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
References: <1D0647598B@vcnet.vc.cvut.cz> <1027607665.9488.75.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-07-25 at 13:50, Petr Vandrovec wrote:
> 
>>On 25 Jul 02 at 14:08, Alan Cox wrote:
>>
>>
>>>+   OUT_BYTE(0x00, 0xCFB);
>>>+   OUT_BYTE(0x00, 0xCF8);
>>>+   OUT_BYTE(0x00, 0xCFA);
>>>+   if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCF8) == 0x00) {
>>
>>                                            ^^^^^
>>It should be 0xCFA according to arch/i386/pci/direct.c...
> 
> 
> Correct. Martin I agree with this change.

Thanks. I noted it already.



