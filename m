Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273147AbRIUJck>; Fri, 21 Sep 2001 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273137AbRIUJca>; Fri, 21 Sep 2001 05:32:30 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:60289 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S272966AbRIUJc2>; Fri, 21 Sep 2001 05:32:28 -0400
Message-ID: <3BAB0858.C22F5177@rcn.com.hk>
Date: Fri, 21 Sep 2001 17:28:56 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Wrapfs a stackable file system
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am rewriting he wrapfs from the fist project and is now in a debugging
stage, it is now quite ready for experimental tests.

The idea is orinigally from FiST, a stackable file system. But the FiST
owner Erez seems given up to maintain the project. At the time I receive
the code, it is so buggy, even unusable, lots of segmentation fault
problems. I have debugging the fs for quite a while. Now it is useful in
just use as a file system wrapper. It is useful in chroot environments
and hardlinks aren't available. It wraps a directory and mount to
another directory on tops of any filesystems. I wish to maintain this
file system development since FiST's idea is good. It allow to use this
base wrapfs as a template and then you can do encryption and other
operations on it with fast development time. If any kernel file system
maintainer is interested, please contact me .. I would like to get help
to finish up my debugging work. The result will be GPL'ed. I will also
package it with the fistgen package as a file system development tool.
Thanks.

regards.

David Chow
