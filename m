Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271064AbTGPLab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271065AbTGPLab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:30:31 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:27278 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271064AbTGPLa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:30:26 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 16 Jul 2003 13:45:17 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: BUG REPORT 2.4.22-pre5/pre6: nfs-clients 2.4.21 stall under heavy
 load on server 2.4.22-pre5/pre6
Message-Id: <20030716134517.4e726b5a.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

subject says about all I can tell. If you take around 20 clients and let them
do heavy nfs action on a 2.4.22-pre5/pre6 server some seem to draw bad cards
and
stall forever with:

Jul 13 02:02:35 test-2 kernel: nfs: server nfsserver.in.my.domain not
responding, still trying

These messages show up with other kernels on server, too. But I cannot remember
one where they do never recover. Even under 2.4.22-pre5/pre6 server they often
recover, but not always. 

If there is something to test or you need further information please let me
know.

Regards,
Stephan
