Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281284AbRKTTp0>; Tue, 20 Nov 2001 14:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281304AbRKTTpO>; Tue, 20 Nov 2001 14:45:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281284AbRKTTnd>; Tue, 20 Nov 2001 14:43:33 -0500
Message-ID: <3BFAB25B.2080200@zytor.com>
Date: Tue, 20 Nov 2001 11:43:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux can use a mountpoint for 2 Filesystems
In-Reply-To: <UTC200111201941.TAA317995.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> hpa:
> 
> 
>>There are real reasons to overmount a filesystem.  It's getting to be
>>a usability problem, probably because Linux (UNLIKE MOST OTHER UNIXES)
>>didn't allow it until just recently.  This change caused some
>>problems, including with the automount daemon.  I would like to see an
>>option to mount(8) to allow it, by default disallow by policy.
>>
> 
> mount(8) does not necessarily have such information:
> /etc/mtab is just a random file with random contents,
> and /proc/mounts need not exist.
> 
> The cleanest way to do what you suggest would be to make the kernel
> refuse an overmount unless the mount(2) flags included the
> "overmount" flag.
> 


Agreed.

	-hpa


