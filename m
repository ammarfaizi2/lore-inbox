Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264784AbRF1WUv>; Thu, 28 Jun 2001 18:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbRF1WUm>; Thu, 28 Jun 2001 18:20:42 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:33041 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264780AbRF1WUM>;
	Thu, 28 Jun 2001 18:20:12 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com> <d33d8kbdel.fsf@lxplus015.cern.ch> <15163.43319.82354.562310@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 29 Jun 2001 00:20:03 +0200
In-Reply-To: "David S. Miller"'s message of "Thu, 28 Jun 2001 15:01:27 -0700 (PDT)"
Message-ID: <d3u2109rho.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Jes Sorensen writes:
>>  Because on ia64 you will get back a 64 bit pointer if you use
>> pci_set_dma_mask() to set a 64 bit mask before calling the pci
>> functions in question.

David> Please note that this is nonstandard and undocumented behavior.

David> This is not a supported API at all, and the way 64-bit DMA will
David> eventually be done across all platforms is likely to be
David> different.

Well please also note there has been requests for proper 64 bit DMA
support for over 3 years or so by now.

The interface we use works well, so why should it be changed for other
architecures? Instead it would make a lot more sense to support it on
other architectures that can do 64 bit DMA.

Jes
