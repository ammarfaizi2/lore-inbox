Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265478AbUF2FpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUF2FpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUF2FpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:45:11 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:6993 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265478AbUF2FpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:45:08 -0400
Message-ID: <40E101E1.3000706@yahoo.com.au>
Date: Tue, 29 Jun 2004 15:45:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: odd dmesg for bootup of 2.6.7-mm3
References: <200406290120.35345.gene.heskett@verizon.net>
In-Reply-To: <200406290120.35345.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

> Finally, which scheduler is the prefered scheduler now?  I'm using cfq 
> because it seems to be more stable for the keyboard autorepeat 
> functions where the default can put me well below once per second and 
> lag to beat all in kmail.
> 

Please try the default scheduler (anticipatory), and let me
know of any problems. It really shouldn't be causing this.
It is the disk IO scheduler.
