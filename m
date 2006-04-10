Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWDJKST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWDJKST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWDJKST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:18:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751116AbWDJKSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:18:18 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200604082106.k38L61j25619@apps.cwi.nl> 
References: <200604082106.k38L61j25619@apps.cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: strlen_user and keys 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 10 Apr 2006 11:18:06 +0100
Message-ID: <5374.1144664286@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Andries.Brouwer@cwi.nl> wrote:

> strnlen_user() is documented as returning the string length including
> terminating NUL.

There's now a strndup_user() in Linus's git tree.

> security/keys/keyctl.c does

This now uses strndup_user().

David
