Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132602AbRDGIDi>; Sat, 7 Apr 2001 04:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbRDGID2>; Sat, 7 Apr 2001 04:03:28 -0400
Received: from [192.38.9.229] ([192.38.9.229]:27636 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S132602AbRDGIDW>; Sat, 7 Apr 2001 04:03:22 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200104060533.f365X2O00959@bagpuss.swansea.linux.org.uk>
Subject: Re: Proper way to release binary-only driver?
To: Brendan.Miller@Dialogic.com (Miller, Brendan)
Date: Fri, 6 Apr 2001 01:33:02 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com> from "Miller, Brendan" at Apr 05, 2001 06:58:34 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the need to distribute a binary-only driver (no flames, please), but
> I am not certain how to build it so that it can be used on multiple kernel
> versions.  (Or is this impossible?)

You must build with the same compiler, same tree and options as the
kernel itself.

> I didn't find any "HOWTO (or recommendation) for proper binary-only driver
> release etiquette", so if there are some preferred means, please let me
> know.

The only recomendation is "dont". 

