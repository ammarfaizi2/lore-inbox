Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316222AbSEVP5L>; Wed, 22 May 2002 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEVP5K>; Wed, 22 May 2002 11:57:10 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:11703 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316221AbSEVP5J>; Wed, 22 May 2002 11:57:09 -0400
Date: Wed, 22 May 2002 08:56:28 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>
cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <1404136612.1022057787@[10.10.2.3]>
In-Reply-To: <E17AXWu-0001vL-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 7.3 has some of what is needed but not all. 

Can you outline the changes in this area? I want to make sure we're
not all fighting the same problems seperately ;-) I know bounce
buffers is one large element of that, though I believe you still
only go up to 4Gb, unless I'm mistaken?

> To go past 16Gb you need highmem mapped page tables which I'm 
> pretty sure did not  make it in.

You need it earlier than that if you have many large tasks (4Gb
or so).

M.
