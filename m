Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTGIAB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTGIAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:01:28 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:57348 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265500AbTGIAB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:01:27 -0400
Date: Wed, 9 Jul 2003 02:11:52 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCHKIT] 2.5.74 - seq_file conversion of /proc/net/atm
Message-ID: <20030709021152.B11897@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  here comes a first cut at the aforementioned subject. It is divided in
height parts for easier review/integration/flamefest:

1 - devices;
2 - utility and common code for vcs (vc/pvc/svc);
3 - pvc;
4 - svc;
5 - vc;
6 - arp;
7 - lec;
8 - final cleanup.

Each part includes a short description. It is possible to build after
1), 5), 6), 7), 8) (and probably more but it hasn't been tested).

Some testing has been done with a couple of uniprocessor systems:
- 1 behaves well with one or two iphase adapters in the same box;
- 3, 4, 5 doesn't crash and it even seems to display the right number
  of vc. More testing to come;
- same comments apply for 6;
- 7 is completely untested. If somebody has typical scripts at hand for
  a back-to-back lane configuration, he will be welcome.

--
Ueimor
