Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSDLVKj>; Fri, 12 Apr 2002 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSDLVKi>; Fri, 12 Apr 2002 17:10:38 -0400
Received: from web13409.mail.yahoo.com ([216.136.172.17]:17670 "HELO
	web13409.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314138AbSDLVKi>; Fri, 12 Apr 2002 17:10:38 -0400
Message-ID: <20020412211037.55635.qmail@web13409.mail.yahoo.com>
Date: Fri, 12 Apr 2002 14:10:37 -0700 (PDT)
From: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: /proc/stat page in and out values
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

howdy,

In /proc/stat the record as

page x y 

which indicates cumulative page in and out values.
To my best undertstanding this info is stored in 
kstat.pgpgin and kstat.pgpgout.

However the values are incremented in submit_bh in
ll_rw_blk.c. So are we actually counting the buffers
we write in and out or the pages; or is it the same ?

thanks
Ravi

__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
