Return-Path: <linux-kernel-owner+w=401wt.eu-S965100AbXAJVRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbXAJVRS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXAJVRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:17:17 -0500
Received: from [85.33.2.18] ([85.33.2.18]:3391 "EHLO smtp-out13.alice.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965100AbXAJVRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:17:17 -0500
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 16:17:17 EST
Date: Wed, 20 Dec 2006 00:38:48 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hard lock with a CD-R and k3b
Message-Id: <20061220003848.1a22a1e4.pochini@shiny.it>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2007 21:00:57.0336 (UTC) FILETIME=[6CB10F80:01C734FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a CD-R that makes linux lock hard when I start k3b. I copied these
messages from the console by hand (I hope there are no errors). NB: these
are not kernel messages (there's nothing in the logs and sysrq doesn't
work). This is what k3b prints and I'm aware it's not very useful:

[...]
Diskinfo:
	mediatype:		CD-R
	current profile:	CD-R
	disk state:		incomplete
	empty:			false
	rewritable:		false
	appendable:		true
	sessions:		4
	tracvks:		4
	layers:			1
	capacity:		... LBA 336601 ...
	remaining size:		... LBA 25803 ...
	used size:		... LBA 310798 ...
====
SCSi command failed:
	command:		READ DVD STRUCT (ad)
	errorcode:		70
	sense key:		illegal request (5)
	asc:			30
	ascq:			2
(k3bdevice::device) /dec/hdf:	READ DVD STRUCTURE length det failed
<BOOM>

I'll try the same CD with other kernel versions/archictures. In the
meantime, have you any hints ?


[Linux Jay 2.6.19 #1 SMP Fri Dec 1 00:06:24 CET 2006 ppc 7455, altivec supported PowerMac3,6 GNU/Linux]

--
Giuliano.
