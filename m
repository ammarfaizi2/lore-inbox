Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUDUCQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUDUCQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 22:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUDUCQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 22:16:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:28294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264255AbUDUCQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 22:16:03 -0400
Date: Tue, 20 Apr 2004 19:15:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1 (and earlier): pdflush taking 100% cpu time
 (profile, .config etc. provided)
Message-Id: <20040420191533.6af76eb2.akpm@osdl.org>
In-Reply-To: <20040420203449.GA21351@middle.of.nowhere>
References: <20040420203449.GA21351@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
>  at times, pdflush is taking over my system:

yup, there's some logic error in there.  If I could reproduce it, it would
be fixed in a jiffy :(

Which filesystems are in active use at the time?  reiserfs?
