Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDSSTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDSSTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDSSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:19:32 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:45975
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261251AbVDSSTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:19:23 -0400
Date: Tue, 19 Apr 2005 11:13:07 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Ananth N Mavinakayanahalli <amavin@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, rusty@rustcorp.com.au,
       suparna@in.ibm.com, prasanna@in.ibm.com, ananth@in.ibm.com
Subject: Re: [RFC] [PATCH] Multiple kprobes at an address
Message-Id: <20050419111307.580b1f53.davem@davemloft.net>
In-Reply-To: <4265061A.9070802@redhat.com>
References: <4265061A.9070802@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005 09:22:34 -0400
Ananth N Mavinakayanahalli <amavin@redhat.com> wrote:

> 1. Is the approach taken by the patch attached good?

I think this simple idea of simply adding a list to the object
is fine.
