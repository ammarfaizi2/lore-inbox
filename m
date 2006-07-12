Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWGLSoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWGLSoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWGLSoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:44:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41121 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932421AbWGLSoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:44:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
In-Reply-To: Ulrich Drepper's message of  Wednesday, 12 July 2006 09:50:06 -0700 <44B5283E.7090806@redhat.com>
X-Shopping-List: (1) Bestial compulsion ghost-melts
   (2) Educated scanty rings
   (3) Injudicious auction beagles
Message-Id: <20060712184412.2BD57180061@magilla.sf.frob.com>
Date: Wed, 12 Jul 2006 11:44:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We could also put the uname info (modulo nodename) into the vDSO.
