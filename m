Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbTGSJPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267952AbTGSJPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 05:15:16 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:36768 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265652AbTGSJPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 05:15:13 -0400
From: Richard Drummond <lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Organization: Private
To: <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] Big-endian fixes for tdfxfb in 2.4.21
Date: Sat, 19 Jul 2003 04:34:08 -0500
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307190131.46394.lists@rcdrummond.net>
In-Reply-To: <200307190131.46394.lists@rcdrummond.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307190434.08829.lists@rcdrummond.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 July 2003 01:39 am, Richard Drummond wrote:
> I've tested this patch extensively both on a Voodoo3 and a Voodoo4 . . .

Ooops. I apologize. It turns out that I didn't test this as thoroughly as I 
had thought. Although the Voodoo3 works perfectly, 16-bit and 32-bit modes  
are still broken on the Voodoo4.

Does anybody have docs on the Voodoo4/5 or know how byte-swizzling woks on 
these cards? It definitely doesn't behave the same as the Voodoo3 . . .

If nobody objects, the patch I posted previously should still be applied to 
2.4 since it does fix all the endian problems in tdfxfb with the Voodoo3.

Cheers,
Rich

