Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268428AbUHLHGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268428AbUHLHGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268429AbUHLHGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:06:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268428AbUHLHGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:06:52 -0400
Date: Thu, 12 Aug 2004 00:05:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: __crc_* symbols in System.map
Message-Id: <20040812000558.220d7e5d.davem@redhat.com>
In-Reply-To: <20040812050136.GA7246@mars.ravnborg.org>
References: <20040811205529.1ff86e9d.davem@redhat.com>
	<20040812050136.GA7246@mars.ravnborg.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 07:01:36 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Would it be an option to skip all 'A' symbols?

I doubt it.  Symbols defined via the linker script will
end up as " A ".  On sparc64 this happens for swapper_pmd_dir,
empty_pg_dir, _etext, _edata, and _end for example.
