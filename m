Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWE2G5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWE2G5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWE2G5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:57:15 -0400
Received: from gw.openss7.com ([142.179.199.224]:18113 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751235AbWE2G5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:57:15 -0400
Date: Mon, 29 May 2006 00:57:05 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060529005705.C20649@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	4Front Technologies <dev@opensound.com>,
	linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1148883077.3291.47.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Mon, May 29, 2006 at 08:11:17AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Mon, 29 May 2006, Arjan van de Ven wrote:
> external modules shouldn't care, they really really should inherit the
> cflags from the kernel's makefiles at which point.. the thing is moot.

Yes, and ultimately the kernel's makefile (if present) are the best
place to get CFLAGS from.  However, the task of ensuring that the
correct Makefile is present and that the correct configuration
information is feeding it (back to .config) is distribution specific
and not always straightforward.

--brian

