Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752035AbWCNJSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbWCNJSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWCNJSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:18:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65491 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751092AbWCNJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:18:32 -0500
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
From: Arjan van de Ven <arjan@infradead.org>
To: Ed Lin <ed.lin@promise.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <NONAMEBgJJ72jYxDwLd000000d3@nonameb.ptu.promise.com>
References: <NONAMEBgJJ72jYxDwLd000000d3@nonameb.ptu.promise.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 10:18:26 +0100
Message-Id: <1142327906.3027.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >> +struct st_sgitem {
> >> +struct st_sgtable {
> >> +struct handshake_frame {
> >> +struct req_msg {
> >> +struct status_msg {
> >
> >Has this all been tested on big-endian hardware?
> >
> 
> No. It was only tested on i386 and x86-64 machines.

you'll want those to be __attribute__((packed)) as well btw



