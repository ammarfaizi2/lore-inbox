Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWIYKqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWIYKqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWIYKqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:46:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30635 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750986AbWIYKqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:46:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060924223925.GU29920@ftp.linux.org.uk> 
References: <20060924223925.GU29920@ftp.linux.org.uk> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 11:44:20 +0100
Message-ID: <22314.1159181060@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> +++ b/include/asm-frv/libata-portmap.h
> @@ -0,0 +1 @@
> +#include <asm-generic/libata-portmap.h>

NAK...  These settings are totally meaningless on FRV.

David
