Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbTLRPFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbTLRPFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:05:36 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:48102 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S265205AbTLRPFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:05:30 -0500
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: module use count & unloading
Date: Thu, 18 Dec 2003 16:03:11 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20031218150525.5504D12001E@sarkovy.koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just learned that it is expected behavior for a module
to be in use while having an in-use count of zero, see
http://bugme.osdl.org/show_bug.cgi?id=1693. If this is
so, how am I supposed to know whether a module can safely
be unloaded? It also seems the old 'autoclean / modprobe -k'
functionality from 2.4 is no longer available in 2.6.

In case this has been discussed before, please accept my
apologies. I just wasn't able to locate the information, so
I am posting here. If anyone wants to respond, please CC me
on your reply, since I am not subscribed to this list.

tk
-- 
Thomas Koeller
thomas@koeller.dyndns.org

