Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbTIEMHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbTIEMHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:07:51 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10880 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262541AbTIEMHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:07:50 -0400
Date: Fri, 5 Sep 2003 13:21:05 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309051221.h85CL5rV000307@81-2-122-30.bradfords.org.uk>
To: clemens-dated-1063536166.2852@endorphin.org, joern@wohnheim.fh-wedel.de
Subject: Re: nasm over gas?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do some benchmarks on lots of different machines and measure the
> performance of the asm and c code.  If it's faster on PPro but not on
> PIII or Athlon, forget about it.

Presumably the asm code is tuned for a specific processor, and
intended to be used only on kernels optimised for that CPU.

On the other hand, unless it's translated to gas, it's more or less
useless in the context of the kernel - remember the 'perl in the
toolchain' discussion?

John.
