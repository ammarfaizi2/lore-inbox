Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVF1Xxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVF1Xxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVF1XpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:45:02 -0400
Received: from free.hands.com ([83.142.228.128]:57759 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S261259AbVF1XYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:24:44 -0400
Date: Wed, 29 Jun 2005 00:33:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: accessing loopback filesystem+partitions on a file
Message-ID: <20050628233335.GB9087@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[if you are happy to reply at all, please reply cc'd thank you.]

hi,

i'm really sorry to be bothering people on this list but i genuinely
don't what phrases to google for what i am looking for without getting
swamped by useless pages, which you will understand why when you see
the question, below.

background:

	i'm sort-of helping test a xen install project where a
	block device is presented as the DRIVE - not, i repeat
	not, the partitions on the drive which is the quotes
	normal quotes way of doing xen installes

	(yes there are good reasons for doing this).

	the thing is that the install is failing, and we'd duh
	like to analyse what's going on (access the log files -
	no, sshd hasn't been installed yet) after terminating
	the xen session [because afaik in xen guest sessions
	there's no way i know of to access virtual consoles 2-6]

the question is, therefore:

	* how the hell do you loopback mount (or lvm mount
	  or _anything_! something!)  partitions that have
	  been created in a loopback'd file!!!!

	  [aside from booting up a second pre-installed xen
	  guest domain and making the filesystem-in-a-file
	  available as /dev/hdb of course.]

answers of the form "work out where the partitions are, then use
hexedit to remove the first few blocks" will win no prizes here.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
