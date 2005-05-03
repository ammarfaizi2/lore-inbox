Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVECLcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVECLcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVECLcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 07:32:24 -0400
Received: from smarthost1.mail.uk.easynet.net ([212.135.6.11]:47883 "EHLO
	smarthost1.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S261477AbVECLcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 07:32:21 -0400
Message-ID: <4277612F.9090503@treblig.org>
Date: Tue, 03 May 2005 12:31:59 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aebr@win.tue.nl, wichert@wiggy.net, linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Just a 'me too'.

Configuration:  2.6.11.3 (SuSE 9.2 tree)
   3ware 9000 hardware raid setup as RAID5,
just over 1.5T total, with a 1.5T partition with ext3
created with mke2fs 1.27 (debian installation).
(A rather slow 1.4GHz Athlon and 512MB of RAM on
the box I'm using to test this RAID).

We'd been running bonnie on the partition for a while and
also created a test file that filled the partition;
then I rm'd that 1.5TB file - this took a while; this took
a long while - probably over an hour, doing a df as it was going showed
the amount of space used dropping.

So then I start to copy stuff onto it and do a df and find it showing
the -64Z on the free. (df (fileutils) 4.1), I've got some stuff 
unbzip'ing on it and it now seems to be showing sensible sizes on it again.

If anyone wants me to try stuff I can since this RAID isn't in service yet.

Dave
