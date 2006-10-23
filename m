Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWJWLWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWJWLWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWJWLWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:22:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9944 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751918AbWJWLWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:22:19 -0400
Subject: Re: [PATCH] do not compile AMD Geode's hwcrypto driver as a module
	per default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Borislav Petkov <petkov@math.uni-muenster.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       info-linux@geode.amd.com
In-Reply-To: <20061021081745.GA6193@zmei.tnic>
References: <20061021081745.GA6193@zmei.tnic>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 12:25:05 +0100
Message-Id: <1161602705.19388.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-21 am 10:17 +0200, ysgrifennodd Borislav Petkov:
> This one should be probably made dependent on some #define saying that the cpu
> is an AMD and has the LX Geode crypto hardware built in. Turn it off for now.

That makes no real sense. Most kernel selections are "run on lots of
processor types", we thus want as much as possible modular, built and
available.

The existing defaults seem quite sane.

