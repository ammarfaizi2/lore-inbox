Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFXUFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFXUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:05:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262318AbTFXUFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:05:02 -0400
Date: Tue, 24 Jun 2003 13:12:28 -0700 (PDT)
Message-Id: <20030624.131228.78737223.davem@redhat.com>
To: bunk@fs.tum.de
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] ULL postfixes for tg3.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030624174811.GW3710@fs.tum.de>
References: <20030624174811.GW3710@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll apply this, the INT64_MAX or whatever ideas are just
stupid.  We're saying what "bits" the device supports when
it does DMA, so we should pass in a "bit" mask.
