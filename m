Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWDLJ1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWDLJ1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWDLJ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:27:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58091 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750934AbWDLJ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:27:22 -0400
Subject: Re: [kernel 2.6] Patch for mxser.c driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bernard Pidoux <pidoux@ccr.jussieu.fr>, linux-kernel@vger.kernel.org,
       Bernard Pidoux <bpidoux@free.fr>
In-Reply-To: <443C2BF4.6070106@gmail.com>
References: <443C1DA0.1030004@ccr.jussieu.fr>  <443C2BF4.6070106@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 10:36:02 +0100
Message-Id: <1144834562.1952.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-04-12 at 00:21 +0200, Jiri Slaby wrote:
> > However, in mxser.c major device numbers are still 174 and 175.
> > 
> > Here is a patch to change major tty device numbers to proper default
> > values.
> > 

NAK

mxser.c is not the Moxa intellio card support, it is SmartIO/IndustIO
support. The IntellIO is different and no longer supported in 2.6

