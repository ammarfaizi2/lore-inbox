Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965643AbWIRKcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965643AbWIRKcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965644AbWIRKcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:32:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965643AbWIRKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:32:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu> 
References: <patchbomb.1158455366@turing.ams.sunysb.edu> 
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dhowells@redhat.com
Subject: Re: [PATCH 0 of 11] Use SEEK_{SET,CUR,END} instead of hardcoded values 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 18 Sep 2006 11:32:36 +0100
Message-ID: <2504.1158575556@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef 'Jeff' Sipek <jeffpc@josefsipek.net> wrote:

> In July, David Howells added SEEK_{SET,CUR,END} definitions to
> include/linux/fs.h
> 
> The following patches convert offenders which were found by grep'ing the
> source tree.

Looks good, though I think you do have to drop the XFS portion of the patch,
though you could strip the comments from the case statements there.

So NAK for the XFS patch, but for the rest:

Acked-By: David Howells <dhowells@redhat.com>
