Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTKOJIf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKOJIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:08:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:45729 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261376AbTKOJIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:08:34 -0500
X-Authenticated: #4512188
Message-ID: <3FB5EDC1.8010805@gmx.de>
Date: Sat, 15 Nov 2003 10:11:29 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Marcus Hartig <marcus@marcush.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance
References: <3FB5B74E.5080707@marcush.de>
In-Reply-To: <3FB5B74E.5080707@marcush.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Hartig wrote:

> Hello all,
> 
> with the Fedora 1 kernel 2.4.22-1.2115.nptl I get with hdparm -t
> (Timing buffered disk reads) 34 MB/sec. Its very slow for this drive.
> 
> With 2.6.0-test9 and -mm3 I get around "62 MB in 3.05 = 20,31". Wow"
> Back to ~1998?

I have a similar problem: With 2.4.22-ac3 I had 37mb/sec with my Samsung 
HD and 49MB/sec with IBM/Hitachi, now with 2.6 (all I tried, including 
test9-mm2) I had only 20mb/sec for Samsung and about 39mb/sec for the 
IBM. Motherboard is Abit NF7-S Rev2.0, as well, so same situation with 
the siimage 1.06 driver. I wanted to run some dd tests as well, but it 
is a real performance hit. Playing with readahead or other hdparm 
options didn't help either.

Prakash

