Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSLaAAO>; Mon, 30 Dec 2002 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSLaAAO>; Mon, 30 Dec 2002 19:00:14 -0500
Received: from host149-39.pool212171.interbusiness.it ([212.171.39.149]:25731
	"EHLO nehwon.homeip.net") by vger.kernel.org with ESMTP
	id <S267176AbSLaAAN>; Mon, 30 Dec 2002 19:00:13 -0500
Message-ID: <3E10EDC8.4030006@unica.it>
Date: Tue, 31 Dec 2002 01:07:20 +0000
From: Roberto De Leo <deleo@unica.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fbdev - boot parameter question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am developing a mini linux CD distro (movix.sf.net) and I would like 
to set up the boot in the following way:  by default the CD should boot 
with the vesa FB support on, but for those cards for which the vesa FB 
fails the kernel should switch _automatically_ to the standard setting 
it would use if it had started with the "video=vesa:off" boot parameter.
What I get now when vesa FB fails to load is instead the kernel prompt 
asking the user to choose among all available console modes, and I would 
be very happy if I could avoid that.

I looked in the LILO HOWTO and in the BootPrompt HOWTO and in the 
bootparam man page but could not find any way to do this.
Any hint would be welcome. If there is no parameter available, can you 
at least let me know which file should I change to set the standard 
linux console mode as the default in case the vesa FB load fails?

Please, CC any answer to my mail address since I am not subscribed to 
the ML.

Thanks,
 Roberto De Leo

