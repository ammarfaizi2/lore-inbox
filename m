Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSE3Jlk>; Thu, 30 May 2002 05:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSE3Jlj>; Thu, 30 May 2002 05:41:39 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:15109 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S316530AbSE3Jli>;
	Thu, 30 May 2002 05:41:38 -0400
Message-ID: <3CF5F3D2.3020505@epfl.ch>
Date: Thu, 30 May 2002 11:41:38 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Alessandro Morelli <alex@alphac.it>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,CFT] Tentative fix for agpgart (writing on 'reserved'
 bits)
In-Reply-To: <fa.mm4ng1v.vmenaj@ifi.uio.no> <fa.gciunnv.cnaf99@ifi.uio.no> <3CF1EA3F.4070608@epfl.ch> <1022493086.11859.191.camel@irongate.swansea.linux.org.uk> <3CF1F4C0.5080201@epfl.ch> <1022494620.11859.207.camel@irongate.swansea.linux.org.uk> <3CF1FD4B.8060608@epfl.ch> <1022497386.11859.232.camel@irongate.swansea.linux.org.uk> <3CF205C1.6040408@epfl.ch> <1022498304.11859.239.camel@irongate.swansea.linux.org.uk> <3CF2144C.709@epfl.ch> <1022509981.11859.284.camel@irongate.swansea.linux.org.uk> <5.1.0.14.0.20020528103408.02ab1260@shiva.intra.alphac.it> <5.1.0.14.0.20020530110655.02afbb20@shiva.intra.alphac.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Morelli wrote:

> 
> Hello
> I managed to get rid of customers, in order to test the patches....
> Bad news...no change...

At least it is not worse (I hope ...) ;-)


> I'm starting to believe I'm mad...my PC works like charm without AGP and 
> gets all mixed when I enabled it...

Does it start messing right after you enable it, or only after you write 
to it (starting X...) ?

> What kind of information can I provide (/proc readings, tests, etc.) to 
> shed some light?
 >
> Could this be a case of interaction between AGP and VM?
> 
> tlb-flush weirdness?
> 

Apart from this kinda usual write-on-reserved-bits in the AGP 
initialization, which has been done before on various chipsets and 
almost never caused any trouble, I saw no blatant errors that may lead 
to such things... In fact, we have several PCs with i815 chipsets in the 
lab. People are using AGP without any troubles. The only difference is 
that we run an old kernel version (2.4.3-13, thanks the sysadmin for 
never upgrading....), and we have a different graphic card (Matrox).

Alan, do you have any idea about this one ?

Best regards
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)


