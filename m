Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUFVUMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUFVUMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUFVUKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:10:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265655AbUFVUBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:01:38 -0400
Date: Tue, 22 Jun 2004 13:01:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [profile]: [21/23] use atomic_t for prof_buffer
Message-Id: <20040622130116.6e12a15a.davem@redhat.com>
In-Reply-To: <0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com>
References: <0406220817.4aXa3aHb5aMb4a3a1aYaZa3aIbXa5aIbKbJbXa1aLbJb4a2a2aZaYa0aHb2aMbYa15250@holomorphy.com>
	<0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 08:17:55 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> Convert prof_buffer to an array of atomic_t's.

Part of a data type exported to userspace, is it not?
Thus, is it really valid to change it like this?
