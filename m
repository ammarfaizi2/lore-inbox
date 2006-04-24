Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWDXVgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDXVgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWDXVgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:36:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751188AbWDXVgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:36:23 -0400
Date: Mon, 24 Apr 2006 14:38:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, mita@miraclelinux.com
Subject: Re: [patch 2/4] kref debugging config option
Message-Id: <20060424143845.39412304.akpm@osdl.org>
In-Reply-To: <20060424083342.069630000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
	<20060424083342.069630000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:
>
> This patch converts all WARN_ON() in kref code to BUG_ON().

Why?  This change will irritate testers and will decrease their ability to
capture (and hence report) diagnostic info.
