Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUFPSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUFPSCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFPR7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:59:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:951 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264371AbUFPR6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:58:51 -0400
Date: Wed, 16 Jun 2004 10:52:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: markh@osdl.org, James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       mark_salyzyn@adaptec.com, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aacraid 32/64 ioctl support (update)
Message-Id: <20040616105231.74bb78c9.davem@redhat.com>
In-Reply-To: <20040616175325.GA16751@infradead.org>
References: <1087401137.13488.61.camel@markh1.pdx.osdl.net>
	<20040616160107.GA14144@infradead.org>
	<20040616160232.GB14144@infradead.org>
	<1087405920.13488.82.camel@markh1.pdx.osdl.net>
	<20040616171924.GA15925@infradead.org>
	<1087408316.13488.93.camel@markh1.pdx.osdl.net>
	<20040616175325.GA16751@infradead.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 18:53:25 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> > I just noticed this.  Can we use memset on a user pointer?  If not, what
> > would be the best way to handle this?
> 
> 
> Good question.  Maybe the architecture-folks know an answer?

Use clear_user()

