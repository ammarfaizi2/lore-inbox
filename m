Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUEaOuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUEaOuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEaOuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:50:24 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:18676 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264640AbUEaOuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:50:21 -0400
Message-ID: <40BB3751.6060200@kegel.com>
Date: Mon, 31 May 2004 06:46:57 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: bjornw@axis.com, linux-kernel@vger.kernel.org
Subject: Delete cris architecture?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on linux-2.6.6, 'make oldconfig' fails on cris with

scripts/kconfig/conf -o arch/cris/Kconfig
arch/cris/Kconfig:158: can't open file "arch/cris/drivers/Kconfig"
make[1]: *** [oldconfig] Error 1

This was reported about a year ago on 2.6.0-test2:	
http://mhonarc.axis.se/dev-etrax/msg03456.html
but it seems nothing has been done about it.

Since step 1 of building a linux kernel for cris seems to have
been dead in the water for almost a year with no
action from the port's maintainer, perhaps the port
should be deleted from the main kernel tree.

Or perhaps the maintainer could submit a fix.  His choice :-)
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
