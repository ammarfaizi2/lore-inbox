Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUKIRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUKIRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKIRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:01:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28632 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261583AbUKIRAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:00:49 -0500
Subject: Re: [PATCH] EXT3 compiler warning fix
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davidm@snapgear.com, linux-kernel <linux-kernel@vger.kernel.org>,
       uclinux-dev@uclinux.org, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200411081432.iA8EWeV0023371@warthog.cambridge.redhat.com>
References: <200411081432.iA8EWeV0023371@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1100019598.2115.223.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Nov 2004 17:00:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-11-08 at 14:32, dhowells@redhat.com wrote:
> The attached patch fixes an uninitialised variable warning in ext3. The
> compiler is wrong in this case because it can't analyse the code sufficiently.

Looks good to me.

--Stephen

