Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUHTHq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUHTHq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHTHq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:46:27 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:62084
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267633AbUHTHqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:46:05 -0400
Message-ID: <4125AC3B.8060707@bio.ifi.lmu.de>
Date: Fri, 20 Aug 2004 09:46:03 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>	 <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain>
In-Reply-To: <1092925942.28353.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-08-19 at 15:32, Frank Steiner wrote:
> 
>>What a stupid claim. When I call cdrecord on SuSE 9.1, I can burn CDs and
>>DVDs as normal user, without root permissions, without suid, without ide-scsi,
>>using /dev/hdc as device.
>>
>>And this just works fine. So where's the problem?
> 
> 
> You can also erase the drive firmware as a user etc. That's the problem.

Hmm, but that's not a problem specific to the SuSE versions, is it?
Joerg was claiming that SuSE release "defective" versions that impact his
reputation. And I can't see that, because the versions shipped with at least
7.3, 9.0 and 9.1 just work fine (that's the versions I used).

The security thing and the problems with 2.6.8.1 keeping users from burning
(I have my set patched in now to allow users burning again, nor sure if
it is safe...) is a general issue as far as I understand, and nothing
SuSE specific.
Please correct me if I'm wrong!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

