Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSBHEZa>; Thu, 7 Feb 2002 23:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSBHEZL>; Thu, 7 Feb 2002 23:25:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51207 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291400AbSBHEZD>; Thu, 7 Feb 2002 23:25:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: 2.4.18-pre9: iptables screwed?
Date: 7 Feb 2002 20:24:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3vjts$r7l$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error with iptables on 2.4.18-pre9:

sudo iptables-restore < /etc/sysconfig/iptables
iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
Abort (core dumped)

However, if I apply the rules manually (using iptables), I have no
problem; only if I'm using iptables-save or iptables-restore do I get
a dump...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
