Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUACSrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUACSrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:47:32 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:57485 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263787AbUACSra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:47:30 -0500
From: Roman Gaufman <hackeron@dsl.pipex.com>
Reply-To: hackeron@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: Truncated 'last' output, please help!
Date: Sat, 3 Jan 2004 18:54:00 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401031854.00698.hackeron@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is my first message. I am having problems with the 'last' command which
is part of the package found on:
http://www.kernel.org/pub/linux/utils/util-linux/

I have the following bug reports:
1) It truncates username to 8 characters, potpockey becomes potpocke
2) any truncated output cannot be fixed with awk or cut 
	(example ps: aux | awk '{ print $11 } fixes truncated output for ps)

and following feature requests: pretty please :)
1) Seconds support is a must for me
2) General output modification without parsing

Could someone please provide a fix or an alternative, because I highly require
this functionality of being able to get a list of:
Login time , Login duration, IP and Username and require seconds support
     (Login times either as timestamp or date with seconds will do, but need 
seconds)

I tried searching for parsing /var/wtmp with perl and other related keywords
to wtmp, but cannot find anything :(.

I'm currently just looking at source code for last while reading some C
tutorials and trying to make a fix, but I'm sure anything I write won't be
near as elegant comming for a C noob such as myself, but am willing to try if
needed.
