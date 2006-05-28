Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWE1Id3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWE1Id3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWE1Id2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:33:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:32197 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751354AbWE1Id1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:33:27 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Jeff Garzik <jeff@garzik.org>, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace 
In-reply-to: Your message of "Sat, 27 May 2006 14:42:02 +0200."
             <Pine.LNX.4.61.0605271441080.4857@yvahk01.tjqt.qr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 May 2006 18:33:14 +1000
Message-ID: <8694.1148805194@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt (on Sat, 27 May 2006 14:42:02 +0200 (MEST)) wrote:
>And the CL form is
>  perl -i -pe '...'
>Somehow, you can't group it to -ipe, but who cares.

-i takes an optional extension which is used to optionally create
backup files.  As such, -i must be followed by space if you want no
extension (and no backup).

