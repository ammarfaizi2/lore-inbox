Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTEGAnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTEGAnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:43:23 -0400
Received: from fmr03.intel.com ([143.183.121.5]:41186 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262742AbTEGAnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:43:22 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FDEAD@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: Robert Love <rml@tech9.net>,
       "lkml (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: RE: PATCH: Replace current->state with set_current_state in 2.5.6
	8  
Date: Tue, 6 May 2003 17:33:26 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Gabriel Devenyi [mailto:devenyga@mcmaster.ca]
> 
> This patch appies to 2.5.68 and replaces any remaining current->state
lines
>  with set_current_state. This from the TODO list of Kernel Janitors.
> 
>
http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-set_current_state.patch

Some time ago I sent a patch doing this only on */fs/* [not the filesystem's
code, just the common stuff]. It was dismissed by Linus under
I-don't-know-what
-the-hell-reasons (it's very smart to dismiss something without reason,
gives
the original poster a very clear idea of what needs to be changed -
nevermind,
just being ironic). 

However, I'd suggest to post this into the Kernel Janitors mailing list and
let one of the big guys there swipe it in.

Maybe Robert Love can provide more highlight.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
