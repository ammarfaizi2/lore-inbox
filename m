Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTE3PIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTE3PIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:08:19 -0400
Received: from gw.enyo.de ([212.9.189.178]:23308 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263748AbTE3PIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:08:19 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.5.70] Config options for PS/2 console
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 30 May 2003 17:21:38 +0200
Message-ID: <87smqw5ukd.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which config options are *required* for PS/2 keyboard support?

With 2.5.70 (or 2.5.69) I cannot use remote console redirection of a
Siemens Primergy H450 system.  Some keys are dead, others result in
error messages such as:

atkbd.c: Unknown key (set 0, scancode 0xed, on isa0060/serio0) pressed.         

2.4.x worked fine (but I didn't enable special input support or things
like that).
