Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264862AbUFHGn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbUFHGn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUFHGn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:43:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:18406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264862AbUFHGn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:43:28 -0400
Date: Mon, 7 Jun 2004 23:42:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-Id: <20040607234235.1728f826.akpm@osdl.org>
In-Reply-To: <20040608063417.GB19170@pazke>
References: <20040603015356.709813e9.akpm@osdl.org>
	<20040607124125.GT3776@pazke>
	<20040607220157.1e67ec39.akpm@osdl.org>
	<20040608051808.GA19170@pazke>
	<20040607222513.6bebcbb6.akpm@osdl.org>
	<20040608063417.GB19170@pazke>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> wrote:
>
> > Thanks.  Could you please regenerate a new diff?  The last one I had
>  > doesn't seem to apply.
> 
>  Patch rediffed agains 2.6.7-rc2-mm2 attached.

Thanks, that works.

It would be good if you could convert a couple of the existing dmi checks
over to this API.  That way people can see how to use them and we know that
the new code is getting some exercise.

Choosing some commonly-used table entries would be best.
