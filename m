Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUEZRDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUEZRDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265737AbUEZRCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:02:51 -0400
Received: from h020.c000.snv.cp.net ([209.228.32.84]:50090 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S265734AbUEZRBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:01:20 -0400
X-Sent: 26 May 2004 17:01:18 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
From: dag@bakke.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
X-Sent-From: dag@bakke.com
Date: Wed, 26 May 2004 10:01:17 -0700 (PDT)
X-Mailer: Web Mail 5.6.3-1
Message-Id: <20040526100117.22732.h011.c000.wm@mail.bakke.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 09:13:14 -0700 (PDT), dag@bakke.com wrote:

> 
> 
> I experience hangs with xfsdump, when dumping my rootfs to a USB 2.0
> connected drive. The hangs are reproducible within 0.2-2 GB of dump, 

Bah... ambiguity...
xfsdump hangs. Not the kernel. So it could quite possibly be a bug in
xfsdump. But the 

pagebuf_get: failed to lookup pages

message in syslog makes me think otherwise.


Dag B
