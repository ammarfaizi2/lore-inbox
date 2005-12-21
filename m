Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVLURjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVLURjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVLURjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:39:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34452 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751144AbVLURjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:39:05 -0500
Subject: Re: Question on the current behaviour of malloc () on Linux
From: Arjan van de Ven <arjan@infradead.org>
To: Jie Zhang <jzhang918@gmail.com>
Cc: linux-kernel@vger.kernel.org, lars.friedrich@wago.com
In-Reply-To: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 18:39:00 +0100
Message-Id: <1135186740.3456.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
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

On Thu, 2005-12-22 at 01:36 +0800, Jie Zhang wrote:
> Hi,
> 
> I first asked this question on uClinux mailing list. My first question
> is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
> Although I found this issue on uClinux, it's also can be demostrated
> on Linux. This is a small program:


see "overcommit". Disable it if you want the behavior you want...


