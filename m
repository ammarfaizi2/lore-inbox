Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289589AbSBJMp1>; Sun, 10 Feb 2002 07:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSBJMpS>; Sun, 10 Feb 2002 07:45:18 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:9226
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S289589AbSBJMpM>; Sun, 10 Feb 2002 07:45:12 -0500
Message-ID: <3C666D98.70600@alpha.dyndns.org>
Date: Sun, 10 Feb 2002 04:54:48 -0800
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: video4linux-list@redhat.com
CC: Gerd Knorr <kraxel@bytesex.org>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
In-Reply-To: <20020209194602.A23061@bytesex.org> <3C65EFF4.2000906@alpha.dyndns.org> <20020210101130.A28225@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, agreed on all points. Thanks for the clarification.

BTW, is there any chance for vmalloc() and pals to be moved to 
videodev.c, or something higher-up? I realize that vmalloc() can be used 
in instead in most cases, but at the expense of a more complex and 
potentially slower mmap().

-- 
Mark McClelland
mmcclell@bigfoot.com



