Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUHFIl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUHFIl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268103AbUHFIl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:41:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268115AbUHFIlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:41:37 -0400
Date: Fri, 6 Aug 2004 01:41:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, clemens@endorphin.org
Subject: Re: [PATCH] Re-implemented i586 asm AES
Message-Id: <20040806014118.095308e7.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0408060411340.21666-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0408060411340.21666-100000@dhcp83-76.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 04:24:08 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> This code is a rework of the original Gladman AES code, and does not
> include any supposed BSD licensed work by Jari Ruusu.
> 
> Linus converted the Intel asm to Gas format, and made some minor 
> alterations.
> 
> Fruhwirth's glue module has also been retained, although I rebased the
> table generation and key scheduling back to Gladman's code.  I've tested
> this code with some standard FIPS test vectors, and large FTP transfers
> over IPSec (both locally and over the wire to a system running the generic
> AES implementation).
> 
> Please review.

Looks good.  Linus, please apply unless you see some
problem with it.

Thanks James.
