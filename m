Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUCBKP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 05:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUCBKP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 05:15:56 -0500
Received: from kamikaze.scarlet-internet.nl ([213.204.195.165]:5311 "EHLO
	kamikaze.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S261596AbUCBKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 05:15:50 -0500
Message-ID: <1078222546.40445ed266de0@webmail.dds.nl>
Date: Tue,  2 Mar 2004 11:15:46 +0100
From: wdebruij@dds.nl
To: linux-kernel@vger.kernel.org
Subject: include skbuff.h in userspace?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does anyone know whether it is at all possible to access sk_buff structures from
userspace? A simple

#include <linux/skbuff.h>

brings up way too many declaration conflicts between libc headerfiles and linux
headerfiles.

The reason I need this is that I've memory mapped complete sk_buffs into
userspace for a more efficient network monitoring platform (than bpf+libpcap). 

Thanks,

 Willem de Bruijn
 ffpf.sourceforge.net


