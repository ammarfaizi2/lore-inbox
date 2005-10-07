Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVJGKDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVJGKDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVJGKDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:03:08 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:56911 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932309AbVJGKDH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:03:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fTPWx8w4/gqF2YSaiKtkMZDOO//qff9aY7KUDiC9NJidXIi89iw0r2WKmrIO3bBsn/GRXELfK9yzg6BjGgZmZUlk0EFejBtFYKgep+8ZJ8upuUilWIy6AX6FN4oKV+/Ai4JtlGLh6rp36eiQcQOV5g9yyWLtpqvd9OK2aehoNoM=
Message-ID: <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
Date: Fri, 7 Oct 2005 13:03:03 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] vm - swap_prefetch-15
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200510070001.01418.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510070001.01418.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

A teeny-weeny nitpick:

On 10/6/05, Con Kolivas <kernel@kolivas.org> wrote:
> +struct swapped_root_t {

[snip]

> +struct swapped_entry_t {

[snip]

Since these are not typedefs, please drop the _t postfix.

                                  Pekka
