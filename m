Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbRFURkW>; Thu, 21 Jun 2001 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbRFURkM>; Thu, 21 Jun 2001 13:40:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57590 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265065AbRFURjz>;
	Thu, 21 Jun 2001 13:39:55 -0400
Date: Thu, 21 Jun 2001 19:39:21 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106211739.TAA370687.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: more gendisk stuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An hour ago or so I put 07-2.4.6pre5-gendisk on ftp.kernel.org
(and rediffed the previous six patches against 2.4.6pre5).

It has add_gendisk, del_gendisk, get_gendisk, blk_gendisk[]
(a.k.a. register_gendisk, unregister_gendisk, find_gendisk),
so that one now can find the gendisk structure given a kdev_t.

Interestingly, there were complaints several places in the source
about the lack of these, but none of the complainers added them.

Al, I don't know whether you are interested in this stuff, but comments
(other than: "the stuff is full of races") are welcome.

Andries
