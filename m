Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCIXVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCIXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:21:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16095 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262380AbUCIXVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:21:35 -0500
Date: Tue, 9 Mar 2004 15:21:26 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rick Knight <rick@rlknight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dummy network device
Message-Id: <20040309152126.5c59d731.davem@redhat.com>
In-Reply-To: <404E4F34.7000301@rlknight.com>
References: <404E4F34.7000301@rlknight.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 15:11:48 -0800
Rick Knight <rick@rlknight.com> wrote:

> I found the answer. From the archive. Decided to look at dummy.c and 
> numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
> like a charm.
> 
> Question/Suggestion, couldn't this be made an option at configuration? 
> Kind of like number_of_ptys=256.

Specify "numdummies=3" on the module load command line.
