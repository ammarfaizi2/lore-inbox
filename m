Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267530AbUBTEea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267524AbUBTEea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:34:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25518 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267530AbUBTEe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:34:28 -0500
Message-ID: <40358E47.8070109@pobox.com>
Date: Thu, 19 Feb 2004 23:34:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Holroyd <tomh@kurage.nimh.nih.gov>
CC: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 compile failure
References: <Pine.LNX.4.44.0402191833200.23018-101000@kurage.nimh.nih.gov>
In-Reply-To: <Pine.LNX.4.44.0402191833200.23018-101000@kurage.nimh.nih.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Holroyd wrote:
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1332 1663 1657 (parallel[ 
[...]
> Gnu C                  2.96
> binutils 2.14

hum.  You should report this compiler bug to your OS vendor, as "2.96" 
does not exist as a real gcc release.

Recommend trying 2.95.<latest> or 3.3.<latest>...

	Jeff



