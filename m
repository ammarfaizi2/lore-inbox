Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUGFVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUGFVzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGFVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:55:20 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:32489 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S264502AbUGFVzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:55:17 -0400
Date: Tue, 6 Jul 2004 17:55:12 -0400 (EDT)
From: John Heffner <jheffner@psc.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tcp_default_win_scale.
In-Reply-To: <20040706133559.70b6380d.davem@redhat.com>
Message-ID: <Pine.NEB.4.33.0407061751380.10143-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another bit to addr to the firewall / window scale mess:  I remember from
a while ago that the Cisco PIX firewalls would not allow a window scale of
greater than 8.  I don't know if they've fixed this or not.  It seems
like some sort of arbitrary limit.

This is obviously not the problem people are seeing now, but could be a
problem in the future.

  -John

