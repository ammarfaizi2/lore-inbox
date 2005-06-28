Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVF1El6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVF1El6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVF1El5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:41:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262516AbVF1Elx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:41:53 -0400
Date: Mon, 27 Jun 2005 21:40:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Arendt <admin@prnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.12 and IOWAIT
Message-Id: <20050627214016.2046e29e.akpm@osdl.org>
In-Reply-To: <42C0C9A3.9030404@prnet.org>
References: <42C0C9A3.9030404@prnet.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Arendt <admin@prnet.org> wrote:
>
> Hi,
> 
> I have to following problem using kernel 2.6.12: IOWAIT is always at 
> 100% in top, the system seems to be significally slower. Any idea what 
> could lead to this ?

Look for a process stuck in D state in the `ps aux' output.
