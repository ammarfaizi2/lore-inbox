Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCXUJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCXUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:07:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261179AbUCXUGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:06:00 -0500
Date: Wed, 24 Mar 2004 12:05:51 -0800
From: "David S. Miller" <davem@redhat.com>
To: Patrick McHardy <kaber@trash.net>
Cc: gf.dellicarri@ncc.itgate.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Kernel 2.4.25 + VLAN + CBQ disc broken ?
Message-Id: <20040324120551.29254b7c.davem@redhat.com>
In-Reply-To: <4060C0A5.40402@trash.net>
References: <4008E74134355D43998FFFC3D637BB030463DF@starsky.ncc.itgate.net>
	<4060C0A5.40402@trash.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 23:56:37 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Dave, the txqueuelen=0 fix for pfifo_fast apparently didn't went in
> 2.4, this is the patch from 2.6, it applies with minor offset.

Indeed, thanks Patrick I've applied this.
