Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272695AbRIGPAz>; Fri, 7 Sep 2001 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272697AbRIGPAf>; Fri, 7 Sep 2001 11:00:35 -0400
Received: from infinity.ciit.y12.doe.gov ([134.167.144.20]:50706 "EHLO
	infinity.ciit.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S272698AbRIGPAY>; Fri, 7 Sep 2001 11:00:24 -0400
Message-ID: <3B98E111.B1251D12@ciit.y12.doe.gov>
Date: Fri, 07 Sep 2001 11:00:34 -0400
From: Lawrence MacIntyre <lpz@ciit.y12.doe.gov>
Organization: Center for Information Infrastructure Technology
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: hamachi (GNIC-II) and 2.4.9-ac9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I have two machines with the Packet Engines Gigabit Ethernet NIC GNIC-II
(hamachi) running RH7.1.  One is an alpha, the other is a dual-cpu
coppermine P-III on a SuperMicro P3DME motherboard.  I was getting 325
Mb/s between them with the stock RH kernel, and I decided to upgrade to
the 2.4.9 tree.  It won't compile on the alpha, (keyboard stuff, fixed
in -ac1), so I got the ac9 patches, and built the kernel.  It's fine,
except that the hamachi won't work.  ifconfig shows no packets received,
but some errors, there are no strange messages in /var/log/messages.  I
then built the same kernel on the intel box, and the same thing
happened.  No working hamachi.
-- 
                                 Lawrence
                                    ~
------------------------------------------------------------------------
 Lawrence MacIntyre    Center for Information Infrastructure Technology
 865.574.8696   lpz@ciit.y12.doe.gov   http://www.ciit.y12.doe.gov/~lpz
