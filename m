Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVCLLOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVCLLOD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVCLLOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:14:03 -0500
Received: from mail.gondor.com ([212.117.64.182]:45320 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S261566AbVCLLNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:13:16 -0500
Date: Sat, 12 Mar 2005 12:13:02 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bouncing keys and skipping sound with 2.6.11
Message-ID: <20050312111302.GA2803@gondor.com>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com> <20050302200632.GA24529@gondor.com> <20050306185539.GA2149@gondor.com> <422C0228.1000709@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422C0228.1000709@suse.de>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 08:26:32AM +0100, Stefan Seyfried wrote:
> I bet you have CONFIG_ACPI_DEBUG enabled. Disable it or try to put
> #define ACPI_ENABLE_OBJECT_CACHE 1
> at the end of include/acpi/acpi.h (before the last #endif)
> This fixed it for me (and some others).

...and for me - thanks for the hint, I've been running 2.6.11 now for a
few days without any problems.

Jan
