Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWACLRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWACLRe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWACLRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:17:34 -0500
Received: from mx5.mailserveren.com ([213.236.237.251]:20136 "EHLO
	mx5.mailserveren.com") by vger.kernel.org with ESMTP
	id S1751367AbWACLRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:17:34 -0500
Subject: Re: New squawk in logwatch report?
From: Hans Kristian Rosbach <hk@isphuset.no>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601022154.23484.gene.heskett@verizon.net>
References: <200601022154.23484.gene.heskett@verizon.net>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Date: Tue, 03 Jan 2006 12:17:29 +0100
Message-Id: <1136287049.28634.70.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 21:54 -0500, Gene Heskett wrote:
> Greetings;
> 
> Running 2.6.15-rc7, uptime 6d 23:43 atm.
> Going thru the systems email output, I note this in the logwatch file, 
> something I don't recall seeing previously:
>  --------------------- Kernel Begin ------------------------ 
> 
> WARNING:  Kernel Errors Present
>    smb_lookup: find contrib/ircstats2 failed, error=-5...:  1 Time(s)
>    smb_proc_readdir_long: error=-2, breaking...:  2 Time(s)
>    smb_proc_readdir_long: error=-5, breaking...:  1 Time(s)
>    smb_proc_readdir_long: error=-512, breaking...:  1 Time(s)
> 
>  ---------------------- Kernel End -------------------------
> 
> Does anyone have a clue?  Other than its samba related, I have no clue.


I have no idea really, but I think samba is having problems finding
the ircstats2 file/dir. Seems like that comes in contrib with mrtg.

Other than that some googling suggests it might also be due to an
incorrect/unreachable wins server specified in smb.conf.

-HK

