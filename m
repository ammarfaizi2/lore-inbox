Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFBPND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFBPND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:13:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56287 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262429AbTFBPNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:13:01 -0400
Date: Mon, 2 Jun 2003 17:25:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
In-Reply-To: <1054567475.5187.3.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0306021725001.7676-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jun 2003, Arjan van de Ven wrote:

> given that audio mixing also happens in userspace it doesn't sound that
> weird..... niceing wine gives the userspace sound mixer more cpu time :)

well, this depends on the circumstances. Normally the mixing shouldnt take
all that much CPU time, and thus the audio server thread should in theory
be quite interactive.

	Ingo

