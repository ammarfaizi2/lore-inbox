Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTHWUmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbTHWUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 16:42:42 -0400
Received: from birosca.ime.usp.br ([143.107.45.59]:29330 "HELO
	birosca.ime.usp.br") by vger.kernel.org with SMTP id S263009AbTHWUml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 16:42:41 -0400
Date: Sat, 23 Aug 2003 17:41:18 -0300
From: Livio Baldini Soares <livio@ime.usp.br>
To: "O.Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc3
Message-ID: <20030823204118.GA5649@ime.usp.br>
Mail-Followup-To: Livio Baldini Soares <livio@ime.usp.br>,
	"O.Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
References: <3F47C687.7010601@superonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F47C687.7010601@superonline.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

O.Sezer writes:
> cset-20030822_1902.txt.gz was 65143 bytes (Aug 22 17:02, from
> http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/ )
> and now patch-2.4.22-rc2-rc3.gz is 1184422 bytes. What is the
> so big difference in between?

  Seems to be:

Marcelo Tosatti writes:
> Ralf Bächle:
>   o Important DEC/MIPS update
>   o More MIPS update

$ diffstat patch-2.4.22-rc2-rc3 | wc
   1123 3457 80999

$ diffstat patch-2.4.22-rc2-rc3 | grep mips | wc
    962 2955 69378

  So, 85% of the files touched were mips/mips64 specific.

  Cheers!

--  
  Livio B. Soares
