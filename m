Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTHDMPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271710AbTHDMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:15:51 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:43185 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271707AbTHDMPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:15:50 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 14:15:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: FS: hardlinks on directories
Message-Id: <20030804141548.5060b9db.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

although it is very likely I am entering (again :-) an ancient discussion I
would like to ask why hardlinks on directories are not allowed/no supported fs
action these days. I can't think of a good reason for this, but can think of
many good reasons why one would like to have such a function, amongst those:

- restructuring of the fs to meet different sorting criterias (kind of a
database view onto the fs)
- relinking of the fs for export to other hosts via nfs or the like (enhanced
security through artificially constructed, exported trees)

Would a feature like that be seen as "big action" or rather small enhancement
to the fs-layer?
Are there any supporters for this feature out there?

Regards,
Stephan
