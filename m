Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVA1VuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVA1VuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVA1VuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:50:06 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52684
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262782AbVA1VuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:50:02 -0500
Date: Fri, 28 Jan 2005 13:45:19 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: lorenzo@gnu.org, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       netdev@oss.sgi.com, arjan@infradead.org, hlein@progressive-comp.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-Id: <20050128134519.11a0e55d.davem@davemloft.net>
In-Reply-To: <20050128133408.49021343@dxpl.pdx.osdl.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	<1106937110.3864.5.camel@localhost.localdomain>
	<20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	<1106944492.3864.30.camel@localhost.localdomain>
	<20050128124517.36aa5e05.davem@davemloft.net>
	<20050128133408.49021343@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 13:34:08 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> per-cpu would be the way to go here.

Does the sbox get somehow seeded from use to use?
If not, then yes that's the thing to do.
