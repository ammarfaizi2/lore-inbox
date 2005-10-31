Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVJaFqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVJaFqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJaFqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:46:42 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:63366 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932238AbVJaFqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:46:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Fix drivers/macintosh/adbhid.c stupid breakage
Date: Mon, 31 Oct 2005 00:46:36 -0500
User-Agent: KMail/1.8.3
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <17253.44515.562667.86040@cargo.ozlabs.ibm.com>
In-Reply-To: <17253.44515.562667.86040@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310046.37341.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 00:38, Paul Mackerras wrote:
> Commit c7f7a569d9b4ea7c53ab6fcd1377895312d8372b ("[PATCH] Input:
> convert drivers/macintosh to dynamic input_dev allocation") breaks any
> machine with an ADB keyboard or mouse, which includes my G4
> powerbook.  Was it given any testing at all?
> 

No it wasn't because I only have x86 to test with. HOwever it was in -mm
tree for a while...

Sorry about the breakage.

-- 
Dmitry
