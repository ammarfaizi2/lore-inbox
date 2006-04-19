Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDSMps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDSMps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWDSMpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:45:47 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:53713 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750768AbWDSMpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:45:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m1enriwFKn573v2PEsKtNNjFaaIpw4hV10WaILT7Mm7yEwUF2wawIlKpej1XWhZGdFVnWPn1qaCJ0g3O73hA0RPrfX1QKoYuXt80VrFXdM3jkKpqZ4IR78Zd7PwN7e68Fw2hr3VGKoUQ3HnzvVtuGlxI/g+KZ3sSJmyskkQUUaA=
Message-ID: <35fb2e590604190545j10598ba3g36414f5dd804c00f@mail.gmail.com>
Date: Wed, 19 Apr 2006 13:45:46 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [RFC] Connector vs. other netlink users
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

A quick question for y'all about in-kernel uses of netlink.

What's the current collective view about unifying all users behind
some common abstraction? Right now, we have things like connector,
uevent, etc. doing their own thing. I'm not even going to think about
the network code (the real reason this exists in the first place!) for
a moment.

Jon.
