Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUAFWEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUAFWEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:04:32 -0500
Received: from mail.sns.it ([192.84.155.4]:42380 "EHLO sns.it")
	by vger.kernel.org with ESMTP id S264501AbUAFWEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:04:31 -0500
Date: Tue, 6 Jan 2004 23:04:28 +0100
To: linux-kernel@vger.kernel.org
Subject: nfs and UDP
Message-ID: <20040106220428.GA14397@tonelli.sns.it>
Reply-To: mennucc1@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Mail-Followup-To: mennucc1@debian.org
From: debdev@tonelli.sns.it (A Mennucc1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi

(sorry if this is a duplicate, but I did not find the archives
for this list)

I am using  2.6.0, for all my computers.

On my server, I have 2 net cards: one only for ADSL with PPPoE,
the other for the local network, and I use masquerading between the two.

Today I tried to set up NFS on the server, and  it does not work ok.

NFS seems to have no problems in writing large files, but it 
goes haywire when I start compiling the kernel on the NFS client
(the kernel is inside the NFS mount): on the client I see these messages 

 kernel: UDP: short packet: From 192.168.1.1:0 0/136 to 192.168.1.2:1
 kernel: UDP: short packet: From 192.168.1.1:8224 8224/128 to 192.168.1.2:8224
(many of these)

and even this very astounding message

 kernel: UDP: short packet: From 212.216.112.112:6299 33691/126 to 192.168.1.2:256

and NFS does not work; but I am pretty sure that the local net is OK
(I use it a lot )
I also tried to ping at the same time when I was experiencing
the problem, and ping works ok.

Am I the only one seeing this?

a.

-- 
Andrea Mennucc
 "one houndred and fifty - the chicken sings"
