Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758968AbWK2XTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968AbWK2XTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758970AbWK2XTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:19:43 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:64654 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1758968AbWK2XTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:19:42 -0500
X-Originating-Ip: 74.102.209.62
Date: Wed, 29 Nov 2006 18:15:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: just how "sanitized" are the sanitized headers?
Message-ID: <Pine.LNX.4.64.0611291812510.7515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i noticed that, when i generate the sanitized headers with "make
headers_install", there are still a number of headers files that are
installed with variations on "#ifdef __KERNEL__".

  i always thought the fundamental property of sanitized headers was
to be compatible with glibc and have no traces of "KERNEL" content
left.  so what's the purpose of leaving some header files with that
preprocessor content?  thanks.

rday
