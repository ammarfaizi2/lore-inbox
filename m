Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVL0Hwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVL0Hwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVL0Hwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:52:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932225AbVL0Hwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:52:32 -0500
Subject: Re: [PATCH 2.6.15-rc7] clocks: export symbol
	do_posix_clock_monotonic_gettime
From: Arjan van de Ven <arjan@infradead.org>
To: Michal =?iso-8859-2?Q?Maru=B9ka?= <mmc@maruska.dyndns.org>
Cc: linux-kernel@vger.kernel.org, george@mvista.com
In-Reply-To: <m264pbo5zt.fsf@linux11.maruska.tin.it>
References: <m264pbo5zt.fsf@linux11.maruska.tin.it>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Dec 2005 08:52:29 +0100
Message-Id: <1135669949.2926.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 23:20 +0100, Michal Maruška wrote:
> Getting access to monotonic time from modules is indispensable, for instance,
> for modular evdev to timestamp input events with a useful time information.

could you also include the patch to add the user (say evdev) in the same
patch please?


