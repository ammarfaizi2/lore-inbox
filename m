Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S264196AbUE2JEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUE2JEZ (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 29 May 2004 05:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbUE2JEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 05:04:24 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:10168 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264196AbUE2JEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 05:04:24 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: swappiness=0 makes software suspend fail.
Date: Sat, 29 May 2004 19:05:20 +1000
User-Agent: KMail/1.6.2
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Landley <rob@landley.net>, seife@suse.de
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz>
In-Reply-To: <20040528215642.GA927@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291905.20925.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 07:56, Pavel Machek wrote:
> Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
> suspend script...

Really, you should save that value somewhere and then restore it after 
suspend, or those people who do use /proc/sys/vm/swappiness will likely 
complain about it (ie: me).

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
