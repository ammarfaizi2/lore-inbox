Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTLXPSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTLXPSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:18:03 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:21153 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263642AbTLXPRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:17:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: GCS <gcs@lsc.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-mm1
Date: Wed, 24 Dec 2003 10:17:43 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <20031224115342.GA10350@lsc.hu> <20031224122342.GA11399@lsc.hu>
In-Reply-To: <20031224122342.GA11399@lsc.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312241017.44225.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 07:23 am, GCS wrote:
> On Wed, Dec 24, 2003 at 12:53:42PM +0100, GCS <gcs@lsc.hu> wrote:
> > input-02-add-psmouse_proto.patch (?)
>
>  Just found out psmouse_noext is deprecated. I have specified
> psmouse_proto then, but imps and exps (and bare too, but I have not
> tested it, as reading the code it seems psmouse_noext falls back to
> bare) are the same. On the console touchpad is working, under XFree86
> 4.3.0 is not. To be more specific, the buttons do work, but I can not
> move the pointer at all. Well, first I thought the middle two buttons
> are for scrolling, as they are placed (and IIRC, they do scroll under
> m$ win), but the top button is like the left button and the bottom
> button is for paste, ie middle button on three buttons mices.

May we see your dmegs, XF86Config and the parameters you are passing
to GPM please? Btw, what version of GPM are you using?

As far as reverting patches I would start with
input-08-synaptics-protocol-discovery.patch

Dmitry
