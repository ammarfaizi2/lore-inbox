Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTBASl7>; Sat, 1 Feb 2003 13:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTBASl7>; Sat, 1 Feb 2003 13:41:59 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:24314
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S264950AbTBASl6>; Sat, 1 Feb 2003 13:41:58 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-kernel@vger.kernel.org
Message-ID: <80256CC0.0067A8CA.00@notesmta.eur.3com.com>
Date: Sat, 1 Feb 2003 18:51:17 +0000
Subject: [RFC] Little endian Cramfs on big endian machines?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



At the moment the cramfs code in 2.4 & 2.5 uses the native machine endianness
for the filesystem layout. I believe this behaviour has been considered a bug
and that the code changed such that the filsystem is always little endian.

There is some code in CVS at http://sourceforge.net/projects/cramfs which
implements this for 2.4. I tried it a couple of months ago and it seemed OK, but
it breaks backwards compatibility with old filesystems on big endian systems so
I suspect it would never be done in a stable kernel series like 2.4. Should
these changes be merged into 2.5?

     Jon


