Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTKXJHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTKXJHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:07:16 -0500
Received: from [213.229.38.66] ([213.229.38.66]:48530 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S263675AbTKXJHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:07:13 -0500
Message-ID: <3FC1C9F8.4030503@winischhofer.net>
Date: Mon, 24 Nov 2003 10:06:00 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis comparison / assignment operator fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geoffrey Lee wrote:
  > This fixes what seems to be an obvious = vs == bug in the init301.c
  > sis file.
  >
  > It has
  >
  > if (temp = 0xffff) return;
  >
  > which should always be true, so it always returns.

You did notice the "#if 0" - "#endif" around that code, didn't you?

BTW: Patching a more than 10 months old version of that driver is
pointless anyway. The current fb-related development is exclusively done
in James Simmon's fbdev tree, and current versions of the sisfb driver
are obtainable at http://www.winischhofer.net/linuxsisvga.shtml

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org




