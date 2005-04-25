Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVDYTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVDYTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVDYTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:45:59 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:26242
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262749AbVDYTpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:45:45 -0400
Date: Mon, 25 Apr 2005 12:37:27 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Avi Kivity <avi@argo.co.il>
Cc: galibert@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
Message-Id: <20050425123727.48afa956.davem@davemloft.net>
In-Reply-To: <426D4857.6080004@argo.co.il>
References: <20050425170259.GA36024@dspnet.fr.eu.org>
	<426D40D4.8050900@argo.co.il>
	<20050425121953.6b5c3278.davem@davemloft.net>
	<426D4857.6080004@argo.co.il>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 22:43:19 +0300
Avi Kivity <avi@argo.co.il> wrote:

> yes, if he frees the pages immediately after tcp_sendpage, then the 
> reference count would remain elevated until tcp completes sending these 
> pages. 

That's what I meant, sorry for the confusion.
