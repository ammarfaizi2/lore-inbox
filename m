Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281766AbRKZP0W>; Mon, 26 Nov 2001 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281771AbRKZP0M>; Mon, 26 Nov 2001 10:26:12 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:64783 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281781AbRKZPZg>;
	Mon, 26 Nov 2001 10:25:36 -0500
Message-ID: <3C025EED.2010300@epfl.ch>
Date: Mon, 26 Nov 2001 16:25:33 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Didier.Moens@dmb001.rug.ac.be
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C023909.4010202@epfl.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Aspert wrote:

> Hello again
> 
> 
> Here is a patch that _might_ improve things wrt. agp support for i830 
> chipsets. I do not have a i830 box at hand, so it has not been tested 
> (well, it compiles ok. ;-). If you feel like crashing your PC once more, 
> try the patch (against 2.4.15) and tell me whether things became 
> better/worse.
> I assumed that the i830mg without secondary device was working in a way 
> that is similar to other Intel chipsets.
> 

It seems that I made a (silly) confusion between i830M and i830MG. 
Anyway, take my previous patch and replace MG by M wherever it may be 
relevant, and it may do the trick. Anyway, I am not quite sure about the 
differences between those two versions.... (the Intel specs are not 
clear at all about this.)

a+
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

