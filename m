Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbTGVTT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTGVTT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:19:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8467 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S268228AbTGVTT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:19:56 -0400
Date: Tue, 22 Jul 2003 21:35:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing file .
Message-ID: <20030722193500.GA2122@mars.ravnborg.org>
Mail-Followup-To: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>,
	'Sam Ravnborg' <sam@ravnborg.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <F341E03C8ED6D311805E00902761278C0D2A2BE3@xfc04.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F341E03C8ED6D311805E00902761278C0D2A2BE3@xfc04.fc.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 07:41:16AM -0700, MIYOSHI,DENNIS (HP-Loveland,ex1) wrote:
> Thanks Sam.  Shouldn't the Makefile take care of this?
No, the files located in asm-generic is meant to be included from asm-$(ARCH)
if needed.

	Sam
