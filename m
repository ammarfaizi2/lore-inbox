Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSLQTLZ>; Tue, 17 Dec 2002 14:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSLQTLZ>; Tue, 17 Dec 2002 14:11:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23557 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265541AbSLQTLY>; Tue, 17 Dec 2002 14:11:24 -0500
Message-ID: <3DFF78B2.1090405@transmeta.com>
Date: Tue, 17 Dec 2002 11:19:14 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com> 	<3DFF6501.3080106@redhat.com> <1040153030.20804.8.camel@irongate.swansea.linux.org.uk> <3DFF717C.90006@redhat.com>
In-Reply-To: <3DFF717C.90006@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Alan Cox wrote:
> 
> 
>>Is there any reason you can't just keep the linker out of the entire
>>mess by generating
>>
>>	.byte whatever
>>	.dword 0xFFFF0000
>>
>>instead of call ?
> 
> 
> There is no such instruction.  Unless you know about some secret
> undocumented opcode...
> 

Well, there is lcall $0xffff0000, $USER_CS... (no, I'm most definitely
*not* suggesting it.)

	-hpa

