Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVF1PNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVF1PNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVF1PNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:13:12 -0400
Received: from octopus.dnsvelocity.com ([64.21.80.9]:28046 "EHLO
	octopus.dnsvelocity.com") by vger.kernel.org with ESMTP
	id S262036AbVF1PLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:11:04 -0400
Message-ID: <42C16877.6000909@aktzero.com>
Date: Tue, 28 Jun 2005 11:10:47 -0400
From: Andrew Thompson <andrewkt@aktzero.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Baudis <pasky@ucw.cz>
CC: Christopher Li <hg@chrisli.org>, mercurial@selenic.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>	<20050624064101.GB14292@pasky.ji.cz>	<20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz>
In-Reply-To: <20050628150027.GB1275@pasky.ji.cz>
Content-Type: multipart/mixed;
 boundary="------------020209000102070105000101"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - octopus.dnsvelocity.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - aktzero.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020209000102070105000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
>>Mercurial's undo is taking a snapshot of all the changed file's repo file length
>>at every commit or pull.  It just truncate the file to original size and undo 
>>is done.
> 
> "Trunactes"? That sounds very wrong... you mean replace with old
> version? Anyway, what if the file has same length? It just doesn't make
> much sense to me.

I believe this works because the files stored in a binary format that 
appends new changesets onto the end. Thus, truncating the new stuff from 
the end effectively removes the commit.

-- 
Andrew Thompson
http://aktzero.com/

--------------020209000102070105000101
Content-Type: text/x-vcard; charset=utf-8;
 name="andrewkt.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="andrewkt.vcf"

begin:vcard
fn:Andrew Thompson
n:Thompson;Andrew
email;internet:andrewkt@aktzero.com
x-mozilla-html:FALSE
url:http://aktzero.com/
version:2.1
end:vcard


--------------020209000102070105000101--
