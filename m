Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbRDRSL3>; Wed, 18 Apr 2001 14:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRDRSLU>; Wed, 18 Apr 2001 14:11:20 -0400
Received: from msp-65-29-30-175.mn.rr.com ([65.29.30.175]:42381 "HELO
	msp-65-29-30-175.mn.rr.com") by vger.kernel.org with SMTP
	id <S135242AbRDRSLL>; Wed, 18 Apr 2001 14:11:11 -0400
Date: Wed, 18 Apr 2001 13:11:03 -0500
From: Shawn <z3rk@ahkbarr.dynip.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Coping with removal of skb_dataref
Message-ID: <20010418131103.A12107@msp-65-29-30-175.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since the changes to skb_dataref happened,
The following snippit needs to be changed.

#  define SKB_IS_CLONE_OF(clone, skb)   ( \
      skb_dataref(clone) == skb_dataref(skb) \
   )

Can someone with a clue help me change this so it works?

-Shawn

 Your eyes are weary from staring at the CRT.  You feel sleepy.  Notice how
 restful it is to watch the cursor blink.  Close your eyes.  The opinions
 stated above are yours.  You cannot imagine why you ever felt otherwise.

