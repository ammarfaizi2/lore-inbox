Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278589AbRJXPkD>; Wed, 24 Oct 2001 11:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278574AbRJXPjn>; Wed, 24 Oct 2001 11:39:43 -0400
Received: from 0wned.org ([204.50.58.21]:39702 "EHLO nitro.0wned.org")
	by vger.kernel.org with ESMTP id <S278591AbRJXPjh>;
	Wed, 24 Oct 2001 11:39:37 -0400
Message-Id: <200110241540.LAA32586@nitro.0wned.org>
Content-Type: text/plain; charset=US-ASCII
From: George Staikos <staikos@0wned.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 - Turtle Beach Tropez+ brings SMP to it's knees
Date: Wed, 24 Oct 2001 11:38:34 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   I just upgraded an SMP box (asus p2b-d / pii-350's) from 2.4.9 to 2.4.13 
and something is really not right.  Any time an app tries to access the sound 
driver (via mixer or dsp at least), the system slows to a complete crawl.  
It's unusable until it times out (?).   No sound is heard.  The card is a 
Turtle Beach Tropez+, ISA PNP (yeah yeah, it worked before so it should work 
now...), sound drivers loaded:  "opl3, wavefront, cs44232, uart401, ad1848". 
Gameport device is also being used (I assume this shouldn't affect the sound 
card itself though).  I am also loading the wavefront firmware from the 
windows driver - wavefront.os.  There were no kernel error messages at all, 
and quite honestly, other than that, the system was very stable for the few 
minutes that I tested.

   Any suggestions?

-- 

George Staikos

