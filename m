Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273834AbRIREzr>; Tue, 18 Sep 2001 00:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273835AbRIREzi>; Tue, 18 Sep 2001 00:55:38 -0400
Received: from mail.direcpc.com ([198.77.116.30]:46497 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S273834AbRIREz1>; Tue, 18 Sep 2001 00:55:27 -0400
Message-ID: <3BA6D4C0.1010309@ix.netcom.com>
Date: Tue, 18 Sep 2001 00:59:44 -0400
From: Jeffrey Ingber <jhingber@ix.netcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, xpert@XFree86.org, alan@lxorguk.ukuu.org.uk
Subject: [FIXED] Random Sig'11 in XF864 with kernel > 2.2.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem mentioned in the following threads:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.1/0932.html
http://www.xfree86.org/pipermail/xpert/2001-September/011055.html
http://www.xfree86.org/pipermail/xpert/2001-September/011230.html

Is fixed in at least 2.4.9-ac10.  I haven't been a regular user of the 
-ac series so I can't say when exactly this was fixed.  However, this 
problem still persists in Linus 2.4.10-pre10.  Can anyone who chimed in 
with similar problems to mine try said kernel (2.4.9-ac10) and provide 
any feedback?  It would excellent if the exact fix could be identified.

Thanks,
Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)



 > The random Sig 11's are observed in the stock XFree86 4.x drivers with
 > none of the 'extras' enabled, such as DRI on several sets of video cards
 > (Matrox and ATI). I can run both UP and SMP kernels in the 2.2 series
 > and 2.4 UP kernels with unlimited uptimes. However, switching to a 2.4
 > SMP kernel will cause random Sig 11's in X, seemingly irregardless of
 > video card/vendor.=20

I'm aware of the reports. Its very hard to figure out what might be
involved. Later 2.4 kernels we have fixed the odd possible candidate where
segment registers or LDT propogation on SMP might go awry but nothing that
really explains the X11 ones and whether they are PCI/AGP setup , power
management or kernel bug triggered

Alan


