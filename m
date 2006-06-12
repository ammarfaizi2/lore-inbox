Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWFLSLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWFLSLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWFLSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:11:33 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:37311
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751599AbWFLSLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:11:32 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Paul Fulghum <paulkf@microgate.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200606121239_MC3-1-C23E-9AF9@compuserve.com>
References: <200606121239_MC3-1-C23E-9AF9@compuserve.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 13:11:20 -0500
Message-Id: <1150135880.9794.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little more clarification on the TTY_DONT_FLIP
debug output... I don't expect it to trigger at all
as the PPP line discipline does not use it (only n_tty).

The only chance it could trigger is after switching
back to n_tty on termination of the PPP link.

Thanks,
Paul


