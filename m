Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJWIZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTJWIZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:25:17 -0400
Received: from rth.ninka.net ([216.101.162.244]:63373 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261699AbTJWIZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:25:15 -0400
Date: Thu, 23 Oct 2003 01:25:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: John Jasen <jjasen@realityfailure.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4 problem with qlogicfc modules
Message-Id: <20031023012511.1d215747.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310221541140.5719-100000@bushido>
References: <Pine.LNX.4.44.0310221541140.5719-100000@bushido>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Oct 2003 15:43:59 -0400 (EDT)
John Jasen <jjasen@realityfailure.org> wrote:

> If I up the define to 1023, I am able to build a raid array and run tests 
> on it.

This just means that there is some kind of bug in the
qlogicfc driver's handling of the out-of-space condition.

