Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTHaUcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTHaUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:32:14 -0400
Received: from tmi.comex.ru ([217.10.33.92]:54950 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262679AbTHaUcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:32:13 -0400
X-Comment-To: Eric W. Biederman
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ed Sweetman <ed.sweetman@wmich.edu>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Mon, 01 Sep 2003 00:37:27 +0400
In-Reply-To: <m18yp9r2uq.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "31 Aug 2003 14:25:49 -0600")
Message-ID: <m3wuctzhq0.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
	<m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu>
	<20030829213940.GC3846@matchmail.com> <3F4FD2BE.1020505@wmich.edu>
	<20030829231726.GE3846@matchmail.com>
	<m18yp9r2uq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Eric W Biederman (EWB) writes:

 EWB> In light of other concerns how reasonable is a switch to e2fsck that
 EWB> will remove extents so people can downgrade filesystems?

also this could be done following way:
1) remount fs w/o extents support
2) copy files
3) remove old ones

