Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRF2JTc>; Fri, 29 Jun 2001 05:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRF2JTW>; Fri, 29 Jun 2001 05:19:22 -0400
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:20357 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S265797AbRF2JTD>; Fri, 29 Jun 2001 05:19:03 -0400
Date: Fri, 29 Jun 2001 10:18:18 +0100
From: Edmund GRIMLEY EVANS <edmundo@rano.org>
To: linux-kernel@vger.kernel.org
Subject: directory order of files
Message-ID: <20010629101818.A13817@rano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Linux ext2, and some other systems, when you create files in a
new directory, the file system remembers their order:

$ mkdir new
$ cd new
$ touch one two three four
$ ls -U
one  two  three  four

(1) Is there any standard that says a system should behave this way?
Is there any software that depends on this behaviour?

(2) Are there Linux file systems that don't work this way? Maybe
someone with a mounted writable reiserfs could do a quick check.

Please copy replies to me as I am not subscribed. Thanks.

Edmund
