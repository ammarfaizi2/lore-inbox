Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWG0HSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWG0HSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWG0HSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:18:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35749
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932537AbWG0HSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:18:51 -0400
Date: Thu, 27 Jul 2006 00:19:11 -0700 (PDT)
Message-Id: <20060727.001911.38414164.davem@davemloft.net>
To: acahalan@gmail.com
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
From: David Miller <davem@davemloft.net>
In-Reply-To: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Albert Cahalan" <acahalan@gmail.com>
Date: Thu, 27 Jul 2006 02:55:17 -0400

> Writing a reliable debugger with ptrace on Linux is absurdly painful.

This is why people like Roland are working on utrace, it seems to
provide ways to deal with most of the limitations you mention,
especially the signal ones.
