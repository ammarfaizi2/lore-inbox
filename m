Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTLXMiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 07:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTLXMiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 07:38:05 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:46278 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263695AbTLXMiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 07:38:03 -0500
Date: Wed, 24 Dec 2003 13:23:42 +0100
From: GCS <gcs@lsc.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.0-mm1
Message-ID: <20031224122342.GA11399@lsc.hu>
References: <20031224095921.GA8147@lsc.hu> <20031224033200.0763f2a2.akpm@osdl.org> <20031224115342.GA10350@lsc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031224115342.GA10350@lsc.hu>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 12:53:42PM +0100, GCS <gcs@lsc.hu> wrote:
> input-02-add-psmouse_proto.patch (?)
 Just found out psmouse_noext is deprecated. I have specified
psmouse_proto then, but imps and exps (and bare too, but I have not
tested it, as reading the code it seems psmouse_noext falls back to
bare) are the same. On the console touchpad is working, under XFree86
4.3.0 is not. To be more specific, the buttons do work, but I can not
move the pointer at all. Well, first I thought the middle two buttons
are for scrolling, as they are placed (and IIRC, they do scroll under
m$ win), but the top button is like the left button and the bottom button
is for paste, ie middle button on three buttons mices.

GCS
