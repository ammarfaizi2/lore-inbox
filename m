Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUAOLoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUAOLoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:44:22 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:26013
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S266505AbUAOLoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:44:17 -0500
Message-ID: <40067C9B.1080401@winischhofer.net>
Date: Thu, 15 Jan 2004 12:42:19 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net> <20040113190443.GR9677@fs.tum.de> <40048EB4.9010500@winischhofer.net> <20040115113244.GP23383@fs.tum.de>
In-Reply-To: <20040115113244.GP23383@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jan 14, 2004 at 01:35:00AM +0100, Thomas Winischhofer wrote:
> 
>>>Until the framebuffer stuff in 2.6 gets updated, I'm suggesting the 
>>>patch below to mark FB_SIS as BROKEN.
>>
>>I think that's a bit harsh. It basically works, it just illegally uses 
>>some FP operations (as it still does in 2.4 until Marcelo finally 
>>applies the patch I have sent him for three times now - hint, hint)
> 
> 
> Now that -mm uses -msoft-float, this means that FB_SIS does no longer 
> compile...

Well, then mark it BROKEN in -mm....

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



