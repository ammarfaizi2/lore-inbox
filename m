Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315258AbSENHmW>; Tue, 14 May 2002 03:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSENHmV>; Tue, 14 May 2002 03:42:21 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:65037 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S315258AbSENHmU>;
	Tue, 14 May 2002 03:42:20 -0400
Message-ID: <3CE0BFDC.2020507@epfl.ch>
Date: Tue, 14 May 2002 09:42:20 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: graeme fisher <graeme@2d3d.co.za>
CC: linux-kernel@vger.kernel.org, Abraham vd Merwe <abraham@2d3d.co.za>
Subject: Re: Agpgart patch for the i845G
In-Reply-To: <3CE0C17B.F5037970@2d3d.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


> The addresses are the same for the i830mp and i845g so instead of
> duplicating the code I just used the i830 setup functions for the 845g
> as well.

OK. I was just a bit worried by the fact that I could not find any docs 
on this chipset (I have almost all Intel AGP docs so this is a bit 
frustrating :-), but if it works for you, I guess the patch is OK ;-)

> Strictly speaking the comment that you referred to in your mail should
> be changed to reflect i845g and not i830mp.

:-))

Maybe add a few more comments to justify the fact that you call 
intel_830mp_setup, s.t. people reading the code in a few months won't 
ask themselves what the heck is this 845g stuff.

a+

Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

