Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUHEPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUHEPVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267753AbUHEPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:21:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267748AbUHEPVu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:21:50 -0400
Date: Thu, 5 Aug 2004 08:21:30 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: =?ISO-8859-1?B?UGF3ZV9f?= Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, spot@redhat.com, akpm@osdl.org
Subject: Re: Make MAX_INIT_ARGS 25
Message-Id: <20040805082130.354fac9f@lembas.zaitcev.lan>
In-Reply-To: <200408050752.46409.pluto@pld-linux.org>
References: <20040804193243.36009baa@lembas.zaitcev.lan>
	<200408050752.46409.pluto@pld-linux.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004 07:52:46 +0200
Pawe__ Sikora <pluto@pld-linux.org> wrote:

> > -#define MAX_INIT_ARGS 8
> > -#define MAX_INIT_ENVS 8
> > +#define MAX_INIT_ARGS 25
> > +#define MAX_INIT_ENVS 25
> 
> You should also increase the COMMAND_LINE_SIZE.

I'm not doing it because I have nothing better to do, but because we
have a specific requirement. Our software works fine with the current
maximum buffer size. If you have different requirement, please let
me know what kind of situation it is in detail, it might help advocacy.

-- Pete
