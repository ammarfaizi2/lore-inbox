Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVJKPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVJKPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJKPV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:21:58 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:13225 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751392AbVJKPV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:21:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jiv9ptEYvP5uHweH0ODd/FmTh6x5TbAPAAepDMn7sSSQMEccJFZst/fpzDFQLYUFDwf3a7lFjkhsG9qbS84mwjRNMqVSSO68yP/Ss5nFLtpMyOS1kGV3FQP2OhvTBzNRdwA8DcLmEhBf8NdStCHsbvhvOu35nPDNAH90dXxvmoc=
Message-ID: <35fb2e590510110821j177e7c11q5f3eaeeb0bee196d@mail.gmail.com>
Date: Tue, 11 Oct 2005 16:21:56 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Re: Regarding - unresolved symbol
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, vinay hegde <thisismevinay@yahoo.co.in> wrote:

> All the necessary headers are present and I am able to
> see the symbol 'sys_call_table' in System.map. I do
> not see any error in this regard. Can somebody help me
> in pointing out the flaw?

It's a *very bad* idea to start trying to jump around in the
sys_call_table from a module. In fact, the sys_call_table is not being
exported any more for that reason.

Jon.
