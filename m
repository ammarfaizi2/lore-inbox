Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTBXKUQ>; Mon, 24 Feb 2003 05:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTBXKUQ>; Mon, 24 Feb 2003 05:20:16 -0500
Received: from 81-86-107-140.dsl.pipex.com ([81.86.107.140]:64551 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266243AbTBXKUQ>;
	Mon, 24 Feb 2003 05:20:16 -0500
Date: Mon, 24 Feb 2003 10:42:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Edward Killips <camber@yakko.cs.wmich.edu>
Cc: Toplica Tanaskovic <toptan@EUnet.yu>, linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Message-ID: <20030224104256.GA21385@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Edward Killips <camber@yakko.cs.wmich.edu>,
	Toplica Tanaskovic <toptan@EUnet.yu>, linux-kernel@vger.kernel.org
References: <200302220716.54218.toptan@EUnet.yu> <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 06:07:46PM -0500, Edward Killips wrote:
 >  
 > The apeture is now set correctly. The ATI 4.2.0-2.5.1 drivers don't work but I 
 > think that is a dri problem. Everything works fine with the vesa drivers using XFree86 4.2.99.

The ATI drivers rely on some additional changes to agpgart.
I've not yet figured out exactly what it is they're trying to do,
and as the code is quite messy, I haven't found the motivation^Wstomach
to go back and look at their code.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
