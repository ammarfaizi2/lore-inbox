Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWC3KRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWC3KRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWC3KRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:17:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751338AbWC3KRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:17:24 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060330081730.880049000@localhost.localdomain> 
References: <20060330081730.880049000@localhost.localdomain>  <20060330081605.085383000@localhost.localdomain> 
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch 6/8] net/rxrpc: use list_move() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 30 Mar 2006 11:17:11 +0100
Message-ID: <8856.1143713831@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch converts the combination of list_del(A) and list_add(A, B)
> to list_move(A, B) under net/rxrpc.

Acked-By: David Howells <dhowells@redhat.com>
