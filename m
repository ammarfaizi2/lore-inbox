Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSKCPVL>; Sun, 3 Nov 2002 10:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbSKCPVL>; Sun, 3 Nov 2002 10:21:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58771 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262023AbSKCPVF>; Sun, 3 Nov 2002 10:21:05 -0500
Date: Sun, 03 Nov 2002 07:23:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <3700332466.1036308224@[10.10.2.3]>
In-Reply-To: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>
References: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the cure: force_inline will guarantee inlining.
> 
> To use _only_ with functions which meant to be almost
> optimized away to nothing but are large and gcc might decide
> they are _too_ large for inlining.

So aside from the ugliness of code, which one actually runs faster?

M.

