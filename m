Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282844AbRLGQEN>; Fri, 7 Dec 2001 11:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282850AbRLGQED>; Fri, 7 Dec 2001 11:04:03 -0500
Received: from avplin.lanet.lv ([195.13.129.97]:21982 "HELO avplin.lanet.lv")
	by vger.kernel.org with SMTP id <S282844AbRLGQDu>;
	Fri, 7 Dec 2001 11:03:50 -0500
Message-ID: <3C10E85F.7040009@lanet.lv>
Date: Fri, 07 Dec 2001 18:03:43 +0200
From: Andris Pavenis <pavenis@lanet.lv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: nbryant@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > With this patch, it seems to work fine. Without, it hangs on write.

I met case when dmabuf->count==0 when __start_dac() is called. As result
I still got system freezing even if PCM_ENABLE_INPUT or 
PCM_ENABLE_OUTPUT were set accordingly (I used different patch, see 
another patch I sent today).

My latest revision of patch "survives" without problems already some 
hours (normally I'm not listening radio through internet all time, but 
this time I do ...)

Andris





