Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273013AbRIOUMj>; Sat, 15 Sep 2001 16:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273023AbRIOUMT>; Sat, 15 Sep 2001 16:12:19 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:49680 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S273013AbRIOUMP>; Sat, 15 Sep 2001 16:12:15 -0400
Message-ID: <3BA232DB.79510CDC@eisenstein.dk>
Date: Fri, 14 Sep 2001 18:39:55 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGP GART for AMD 761
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
		<3BA22537.94D4EA28@eisenstein.dk> <1000582067.32708.51.camel@phantasy> 
		<3BA228EA.FCD61CA1@eisenstein.dk> <1000583357.32707.54.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> On Fri, 2001-09-14 at 11:57, Jesper Juhl wrote:
> > bash-2.05# /sbin/lspci -n -v -s 0:0
> > 00:00.0 Class 0600: 1022:700e (rev 13)
>
> Thanks.  Ca you try the attached patch? It should fall back on
> try_unsupported if it can't find the 761.  Please send the relevant
> dmesg in reply.  Thank you.

Some aditional detail; it seems the NVidia driver agrees that the AGPGART is working since I get
this at the end of dmesg:

NVRM: loading NVIDIA kernel module version 1.0-1251
NVRM: not using NVAGP, AGPGART is loaded!!

And since my X is working perfectly I'd say it's looking good :)


Best regards,
Jesper Juhl
juhl@eisenstein.dk


