Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264832AbUEMVDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbUEMVDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbUEMVDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:03:06 -0400
Received: from web80512.mail.yahoo.com ([66.218.79.82]:45948 "HELO
	web80512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264832AbUEMVDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:03:05 -0400
Message-ID: <20040513210304.16628.qmail@web80512.mail.yahoo.com>
Date: Thu, 13 May 2004 14:03:04 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: 2.6.6-mm2 and losing keyboard
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz, akpm@osld.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I goofed up splitting i8042 IRQ handling into IRQ+tasklet, -mm2 needs the
following changeset to be reverted for now:

http://dtor.bkbits.net:8080/input/user=dtor_core/cset@409f23a7y-Ir-8MvxQWOnfGOq5XPYw?nav=!-|index.html|stats|!+|index.html|ChangeSet@-4d

I will try to come up with the proper fix later tonight.

Dmitry
