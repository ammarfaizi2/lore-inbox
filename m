Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315205AbSD2Vni>; Mon, 29 Apr 2002 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSD2Vnh>; Mon, 29 Apr 2002 17:43:37 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54147 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315205AbSD2Vnh>; Mon, 29 Apr 2002 17:43:37 -0400
Date: Mon, 29 Apr 2002 15:41:55 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading and physical/logical CPU identification
Message-ID: <26950000.1020120115@flay>
In-Reply-To: <200204291849.NAA23906@popmail.austin.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is, I have 4 physical processors, but kernel.org kernels so far 
> do not recognize all of them.  2.4.18 will find 3, while 2.5.11 will find 
> only 2 (BIOS hyperthreading support off, no acpismp=force).  However, on 
> 2.5.11, if I enable hyperthreading (thru BIOS and acpismp=force, I see 4 
> processors.  

When you say the kernel doesn't recognise all of the physical processors, 
do you mean it doesn't see them in the MPS/ACPI table, or that they fail to 
boot? Can you post your boot log?

I see you have a "us.ibm.com" email address ... is this machine an x440,
one of it's smaller brethren, or something totally different?

M.



