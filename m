Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbSLKMhy>; Wed, 11 Dec 2002 07:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbSLKMhy>; Wed, 11 Dec 2002 07:37:54 -0500
Received: from hicks.adgrafix.com ([64.55.193.2]:26032 "EHLO
	hicks.adgrafix.com") by vger.kernel.org with ESMTP
	id <S266972AbSLKMhx>; Wed, 11 Dec 2002 07:37:53 -0500
Message-ID: <3DF7337D.1080706@tungstengraphics.com>
Date: Wed, 11 Dec 2002 12:45:49 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>,
       Margit Schubert-While <margitsw@t-online.de>,
       linux-kernel@vger.kernel.org, faith@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch> <20021211132059.C11689@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> DRI folks, this seems like duplication given that this data is available
> in agpgart. How about changing this to read whatever agpgart has set in
> .chipset_name ?
> 

And it looks like the mechanism that drm uses for quering agp doesn't return 
the string in question.  (I don't really understand the mechanism these two 
modules use to talk to each other).

In any case I don't think the string in the informational is very useful -- 
it's a potentially inaccurate translation of state from *another* module, so 
I'm just removing the lot.

Keith

