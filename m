Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279598AbRKATRn>; Thu, 1 Nov 2001 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279592AbRKATRY>; Thu, 1 Nov 2001 14:17:24 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:9100 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S279588AbRKATRP>;
	Thu, 1 Nov 2001 14:17:15 -0500
Message-ID: <3BE1A042.7030806@softhome.net>
Date: Thu, 01 Nov 2001 19:19:30 +0000
From: Ricardo Martins <thecrown@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 (unkillable processes)
In-Reply-To: <3BE1777F.30705@softhome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> Procedure
 >> In X windows (version 4.1.0 compiled from the sources) when writing
 >> "exit" in xterm to close the terminal emulator, the window freezes, and
 >> from that moment on, every process becomes "unkillable", including 
xterm
 >> and X (ps also freezes), and there's no way to shutdown GNU/Linux in a
 >> sane way (must hit reset or poweroff).


 >I can see the problem here with 2.4.13. I don't know if it's kernel
 >related, I'm used using rxvt, never xterm.

 >It looks like xterm takes the terminal where you started X from.

 >Are you using devfs ?


 >Pierre


Pierre, yes, i'm using devfs that seems to be the problem, do you know 
how to fix it ?

