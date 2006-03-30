Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWC3KTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWC3KTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWC3KTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:19:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751339AbWC3KTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:19:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060330081731.538392000@localhost.localdomain> 
References: <20060330081731.538392000@localhost.localdomain>  <20060330081605.085383000@localhost.localdomain> 
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Ian Kent <raven@themaw.net>,
       Joel Becker <joel.becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Urban Widmark <urban@teststation.com>,
       David Howells <dhowells@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [patch 8/8] fs: use list_move() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 30 Mar 2006 11:18:47 +0100
Message-ID: <8892.1143713927@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch converts the combination of list_del(A) and list_add(A, B)
> to list_move(A, B) under fs/.

Acked-By: David Howells <dhowells@redhat.com>
