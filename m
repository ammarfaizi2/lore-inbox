Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271927AbRIIRlc>; Sun, 9 Sep 2001 13:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272995AbRIIRlV>; Sun, 9 Sep 2001 13:41:21 -0400
Received: from spr-tik2.ethz.ch ([129.132.119.69]:10681 "EHLO tik2.ethz.ch")
	by vger.kernel.org with ESMTP id <S271927AbRIIRlS>;
	Sun, 9 Sep 2001 13:41:18 -0400
Date: Sun, 9 Sep 2001 19:41:38 +0200
From: Lukas Ruf <ruf@tik.ee.ethz.ch>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: proc_mkdir -> where is proc_rmdir ?
Message-ID: <20010909194137.B1968@tik.ee.ethz.ch>
Reply-To: Lukas Ruf <ruf@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Organization: TIK, ETHZ, Switzerland
X-ID: 0xD20BA2ED
X-URL: www.tik.ee.ethz.ch/~ruf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I created some directories below /proc while a module got installed.
When I de-install the module, I would like to remove these directories as
well?

First, I remove the entries within the directory by remove_proc_entry().
So, the directories are empty.  But when I try to remove the self-created
directories with a similar call to remove_proc_entry(), nothing happens.

So, I simply ask: is there somewhere a proc_rmdir() ?  If not, how do I
need to call the remove_proc_entry() such that the directory gets removed?

Thanks for any help!

Lukas

-- 
Lukas Ruf                        Swiss Federal Institute of Technology
Office: ETZ-G61.2                             Computer Engineering and
Phone: +41/1/632 7312                        Networks Laboratory (TIK)
Fax:   +41/1/632 1035                                      ETH Zentrum
PGP 2.6: ID D20BA2ED;                                    Gloriastr. 35
Fingerprint 6323 B9BC 9C8E 6563  B477 BADD FEA6 E6B7    CH-8092 Zurich
