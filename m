Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWFLEtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWFLEtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 00:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFLEtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 00:49:17 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:5768 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750837AbWFLEtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 00:49:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for atkbd.c from Ubuntu
Date: Mon, 12 Jun 2006 00:49:13 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060524113139.e457d3a8.zaitcev@redhat.com> <200605290059.32302.dtor_core@ameritech.net> <20060528233420.9de79795.zaitcev@redhat.com>
In-Reply-To: <20060528233420.9de79795.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606120049.13974.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 02:34, Pete Zaitcev wrote:
> On Mon, 29 May 2006 00:59:31 -0400, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=2817#c4
> 
> Thanks for letting me know, especially the reference.
>

Pete,

I am backpedaling on that problem. It seems that HANGUEL/HANJA scancodes are
pretty well-defined an we need to make them work properly. Please look here
for the proposed patch:

	http://bugzilla.kernel.org/show_bug.cgi?id=6642

-- 
Dmitry
