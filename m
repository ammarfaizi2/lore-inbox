Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292508AbSB0Oqy>; Wed, 27 Feb 2002 09:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSB0Oqq>; Wed, 27 Feb 2002 09:46:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14611 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292508AbSB0Oqe>; Wed, 27 Feb 2002 09:46:34 -0500
Message-ID: <3C7CF0F6.5060300@evision-ventures.com>
Date: Wed, 27 Feb 2002 15:45:10 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Roberto Nibali <ratz@drugphish.ch>, Helge Hafting <helgehaf@aitel.hist.no>,
        Nathan <wfilardo@fuse.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.5.5-dj2 compile failures
In-Reply-To: <Pine.LNX.4.44.0202271614450.16294-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a sinde note
> -	snd_pcm_lib_preallocate_isa_pages_for_all(pcm, 64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024, GFP_KERNEL|GFP_DMA);
> +	snd_pcm_lib_preallocate_isa_pages_for_all(pcm, 64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);


I think this method should be named as follows:

i_have_no_fear_of_wirst_desease_from_programming_linux_alsa_or_sound_drivers_at_all()


BAH! It should be: spl_alloc_isap() at most!



