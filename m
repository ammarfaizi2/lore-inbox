Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSHBXvA>; Fri, 2 Aug 2002 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBXvA>; Fri, 2 Aug 2002 19:51:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14065 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316821AbSHBXu7>; Fri, 2 Aug 2002 19:50:59 -0400
Subject: Re: modem support under Linux
From: Robert Love <rml@tech9.net>
To: Hell.Surfers@cwctv.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003813645230282DTVMAIL2@smtp.cwctv.net>
References: <003813645230282DTVMAIL2@smtp.cwctv.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 02 Aug 2002 16:54:28 -0700
Message-Id: <1028332468.14922.905.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 16:46, Hell.Surfers@cwctv.net wrote:

> In the linux sources where are the modem drivers kept?

Linux does not have modem "drivers".

In the kernel, modems are handled by the serial driver (drivers/serial/)
or some PCI/winmodem cruft that emulates a serial driver.

User-space handles the actual "profile" of the modem, e.g. what AT
commands it supports etc.

	Robert Love


