Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUFUVHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUFUVHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUFUVHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:07:11 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31978 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266467AbUFUVHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:07:09 -0400
Date: Mon, 21 Jun 2004 17:09:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Kirill Korotaev <kksx@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: can TSC tick with different speeds on SMP?
In-Reply-To: <200406211350.09295.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0406211707190.3273@montezuma.fsmlabs.com>
References: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
 <200406211350.09295.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, James Cleverdon wrote:

> IIRC, in the IA64 manuals Intel, by carefully not making any guarantees
> to the contrary, reserved the right to have the TSC-equivalent register
> not be synchronized either to the bus clock or the CPU clock.
>
> This doesn't directly apply to IA32, but may give a hint as to their
> future intentions.

The intel MP1.4 specification also allows for processors of
varying capabilities, this would include different clock speeds resulting
in differing TSC frequencies.

