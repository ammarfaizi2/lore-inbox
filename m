Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTDVTQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTDVTQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:16:47 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:58785 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263369AbTDVTQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:16:46 -0400
Message-ID: <3EA59949.6040104@free.fr>
Date: Tue, 22 Apr 2003 21:34:33 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine
References: <3EA4FF4C.2030702@free.fr>	 <200304221036.19274.m.c.p@wolk-project.de> <1051020692.14881.12.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051020692.14881.12.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-04-22 at 09:36, Marc-Christian Petersen wrote:
> 
>>>So I hope, it will be updated in rc2...
>>
>>I'll _bet_ that the new well good code from Justin won't make it into 2.4 
>>earlier than 2.4.22-pre1.
> 
> 
> Its not the good code that worries me - its what bits of it turn out to
> be buggy

On the other hand, probably mainy/every server with  dual scsi cards 
(one for 160 Mbps and other for slow devices as tape, cdrom, ...) will 
probably not boot with actual good blessed code :-)

Never mind :
	1) I have warned and done my debugging duty by sending a kdbg backtrace,
	2) I suggested a possible fix,
	3) I have a solution for myself,



-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

