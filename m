Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbTFLS6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTFLS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:58:23 -0400
Received: from maile.telia.com ([194.22.190.16]:49149 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S264951AbTFLS6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:58:18 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: "Joseph Fannin" <jhf@rivenstone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
	<m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz>
	<m2ptlkqpej.fsf@telia.com> <20030612024814.GB4787@rivenstone.net>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Jun 2003 21:11:42 +0200
In-Reply-To: <20030612024814.GB4787@rivenstone.net>
Message-ID: <m23cifnma9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph Fannin" <jhf@rivenstone.net> writes:

> On Wed, Jun 11, 2003 at 11:23:48PM +0200, Peter Osterlund wrote:
> 
> > Here is a new patch that sends ABS_ events to user space. I haven't
> > modified the XFree86 driver to handle this format yet, but I used
> > /dev/input/event* to verify that the driver generates correct data.
> 
>     How well will GPM (for example) work with this?

GPM will need some changes to support the new ABS format, but I think
it will be quite easy to make those changes.

This driver will also make it possible to run GPM and the XFree86
driver simultaneously, something that didn't work before.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
