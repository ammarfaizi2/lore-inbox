Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272749AbRIGQCV>; Fri, 7 Sep 2001 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272751AbRIGQCL>; Fri, 7 Sep 2001 12:02:11 -0400
Received: from infinity.ciit.y12.doe.gov ([134.167.144.20]:59154 "EHLO
	infinity.ciit.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S272749AbRIGQCA>; Fri, 7 Sep 2001 12:02:00 -0400
Message-ID: <3B98EF85.C1CBF8BE@ciit.y12.doe.gov>
Date: Fri, 07 Sep 2001 12:02:13 -0400
From: Lawrence MacIntyre <lpz@ciit.y12.doe.gov>
Organization: Center for Information Infrastructure Technology
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: hamachi (GNIC-II) and 2.4.9-ac9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

If I replace the 2.4.9-ac9 hamachi.c file with the one from the stock RH
7.1 kernel distribution it works fine on the P-III and the alpha.  I
even get better performance with 2.4.9-ac9 than with the stock kernel
(340 Mb/s vs. 325 Mb/s).  There were a lot of changes in hamachi.c
between the two versions. Insmoding the driver with debug=10 showed
these 4 error numbers:
0f32e812 (CRC) 0f32c812 (CRC) 0bc25012 00d30812 (CRC).  From reading the
source, three of those point to CRC, the other isn't mentioned.  I don't
have the hamachi data sheets to look up any other possible errors.  I'm
quite willing to test any fixes if anyone has any ideas.
-- 
                                 Lawrence
                                    ~
------------------------------------------------------------------------
 Lawrence MacIntyre    Center for Information Infrastructure Technology
 865.574.8696   lpz@ciit.y12.doe.gov   http://www.ciit.y12.doe.gov/~lpz
