Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSBEE30>; Mon, 4 Feb 2002 23:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288149AbSBEE3T>; Mon, 4 Feb 2002 23:29:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20754 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288019AbSBEE3L>; Mon, 4 Feb 2002 23:29:11 -0500
Message-ID: <3C5F5F7E.8090703@zytor.com>
Date: Mon, 04 Feb 2002 20:28:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Stevie O <stevie@qrpff.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <5.1.0.14.2.20020204230409.00a886b0@whisper.qrpff.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stevie O wrote:

> At 09:07 PM 2/3/2002 -0800, H. Peter Anvin wrote:
> 
>> Rather than a signal, it should be a file descriptor of some sort, so
>> one can select() etc on it.  Personally I can't imagine polling would
>> take any appreciable amount of resources, though.
> 
> 
> Windows 95 polls the cd-rom drive for autorun.
> It kills laptop batteries REAL quick.
> CPU & memory aren't the only resources...
> 

Does it spin up the CD-ROM doing so?

	-hpa

