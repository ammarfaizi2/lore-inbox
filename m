Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTH0N3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTH0N3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:29:25 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:8338 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261353AbTH0N3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:29:24 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: lists@runa.sytes.net
Subject: Re: Can't get DHCP info on 2.6.0 test4
Date: Wed, 27 Aug 2003 15:29:02 +0200
User-Agent: KMail/1.5.9
References: <56555.127.0.0.1.1061988391.squirrel@webmail.runa.sytes.net>
In-Reply-To: <56555.127.0.0.1.1061988391.squirrel@webmail.runa.sytes.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308271529.03948.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 August 2003 14:46 lists@runa.sytes.net wrote:
> Dear all:
> I've just booted test4 and the dhcp client can't get the network info.
> Also I got some eth timeout messages.
>
> I've tried booting with "noacpi" (I had similar problems with 2.4.x which
> I fixed using 'noacpi') but it didn't worked.

You could try my noacpi-option-fix from:
	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-
test4/2.6.0-test4-mm2/broken-out/noacpi-option-fix.patch

Alternatively cou could try 2.6.0-test4-mm2 which includes the patch.

   Thomas
