Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315808AbSEZILP>; Sun, 26 May 2002 04:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSEZILO>; Sun, 26 May 2002 04:11:14 -0400
Received: from jalon.able.es ([212.97.163.2]:33697 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315805AbSEZILN>;
	Sun, 26 May 2002 04:11:13 -0400
Date: Sun, 26 May 2002 11:11:08 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020526091108.GA1749@werewolf.able.es>
In-Reply-To: <1022360474.21238.5.camel@ldb> <20020525233739.GA2022@werewolf.able.es> <1022380785.11859.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.26 Alan Cox wrote:
>On Sun, 2002-05-26 at 00:37, J.A. Magallon wrote:
>> Gcc-3.1 has also a -march=pentium2 specific target, that is not a synomym
>> for any other.
>> 
>
>Splitting PII from PPro is a good move for another reason. The PPro
>requires a locked spin_unlock due to an errata - the PII seems not to. 
>

So I can kill CONFIG_X86_PPRO_FENCE for a PII ? If yes, I will try.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #1 SMP dom may 26 02:36:58 CEST 2002 i686
