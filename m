Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFBNyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTFBNyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:54:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5401 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262331AbTFBNyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:54:51 -0400
Subject: Re: [PATCH] Fix deadlock in journal_create
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030530213139.GD965@ca-server1.us.oracle.com>
References: <20030530213139.GD965@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054562894.3618.14.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 15:08:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2003-05-30 at 22:31, Mark Fasheh wrote:

> This will get ext3's read_super method to call ext3_create_journal which
> will hang during a journal_create.
> 
> A one line patch is attached. Please let me know what you think.

Looks OK to me.

--Stephen

