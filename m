Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVF1Vb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVF1Vb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVF1Vby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:31:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261435AbVF1Vbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:31:33 -0400
Date: Tue, 28 Jun 2005 14:30:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1]  V4L CX88 patch - against 2.6.12-mm2
Message-Id: <20050628143024.121ba151.akpm@osdl.org>
In-Reply-To: <20050628232157.214c76fd.khali@linux-fr.org>
References: <42C19F6A.6020501@brturbo.com.br>
	<20050628232157.214c76fd.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> Your patch adds trailing whitespace in various places:

Everybody adds trailing whitespace, although usually not so obviously.  I
remove it again.

In this case I expect the hunks which you've noticed came about because of
my cleanup of a previous v4l patch, and whatever system the v4l team are
using is trying to revert upstream changes which aren't in their tree.

But whatever.  `patch -l' works.
