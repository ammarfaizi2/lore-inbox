Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVECWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVECWZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVECWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:25:21 -0400
Received: from peabody.ximian.com ([130.57.169.10]:14785 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261864AbVECWZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:25:14 -0400
Subject: Re: question about Ext2/3 append-only attributes
From: Robert Love <rml@novell.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c1405050313585b1921ba@mail.gmail.com>
References: <4ae3c1405050313585b1921ba@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 May 2005 18:24:34 -0400
Message-Id: <1115159074.6734.42.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 16:58 -0400, Xin Zhao wrote:

> I read some specification says that if append-only is set to a
> directory, you can only create or modify files in that directory, but
> no delete.

I suspect that your interpretation of the specification is wrong.

+a says that files can only be opened in append mode--O_APPEND.  It is
very specific as to what it allows.

Perhaps you want the sticky bit, +t, set on the directory?

	Robert Love


