Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUFOBGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUFOBGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUFOBGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 21:06:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37845 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264906AbUFOBGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 21:06:42 -0400
Date: Mon, 14 Jun 2004 18:01:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Riccardo Scarsi <rscarsi@penguin.polito.it>
Cc: cap@di.fc.ul.pt, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multicast mroute
Message-Id: <20040614180103.43c59ce2.davem@redhat.com>
In-Reply-To: <20040613194240.GA32069@assi.polito.it>
References: <20040613194240.GA32069@assi.polito.it>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can't just blindly change the size of a userland exported
structure.  This will break existing applications.
