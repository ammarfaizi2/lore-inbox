Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTJOJ33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTJOJ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 05:29:29 -0400
Received: from hugin.maersk-moller.net ([193.88.237.237]:59009 "EHLO
	hugin.maersk-moller.net") by vger.kernel.org with ESMTP
	id S262470AbTJOJ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 05:29:28 -0400
Message-ID: <3F8D1377.3060509@maersk-moller.net>
Date: Wed, 15 Oct 2003 11:29:27 +0200
From: Peter Maersk-Moller <peter@maersk-moller.net>
Organization: Visit <http://www.maersk-moller.net/>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aic7xxx lockup for SMP for 2.4.22
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Recent postings on this suggest some changes/problems with
aic7xxx, but none of them seems to be like this.

It seems that the aic7xxx driver while booting a SMP enabled
2.4.22 kernel waits (lock-up?) forever.

The lock-up does not happen if I disable SMP, make distclean
and recompile the kernel.

The controller used is a PCI based Adaptec 29160 (aic7892).

The board is a dual Pentium III DBD100 from Iwill.

Compiler GCC 3.2.3
Distro : Slackware 9.1

Has anyone else seen this ?

Kind regards

----------------------------------------------------------------
Peter Maersk-Moller
----------------------------------------------------------------
Ogg/Vorbis support for MPEG4IP. YUV12, XviD, AVI and MP4 support
for libmpeg2. See http://www.maersk-moller.net/projects/
----------------------------------------------------------------

