Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270360AbUJTNlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270360AbUJTNlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270126AbUJTM47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:56:59 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:27271 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270316AbUJTMwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:52:31 -0400
Subject: Re: [PATCH] implement in-kernel keys & keyring management
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200410191615.i9JGF8IW002712@hera.kernel.org>
References: <200410191615.i9JGF8IW002712@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098276738.2803.18.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 08:52:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 10:58, Linux Kernel Mailing List wrote:
> ChangeSet 1.2260, 2004/10/19 07:58:51-07:00, dhowells@redhat.com

I thought there was a goal to not add multiplexer syscalls anymore,
especially not without thinking about 32/64 bit emulation first...
sounds like it's best to back out this changeset until that bit is
resolved (I thought the agreement was that this one was stuck in -mm
until this got sorted out in the first place)
