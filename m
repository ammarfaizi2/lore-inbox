Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269540AbUI3Vzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269540AbUI3Vzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269563AbUI3Vzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:55:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10897 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269540AbUI3Vz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:55:29 -0400
Message-ID: <415C80C1.8070406@pobox.com>
Date: Thu, 30 Sep 2004 17:55:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Clemens Schwaighofer <cs@tequila.co.jp>,
       "Markus T." <markus@trippelsdorf.net>
Subject: Re: Linux 2.6.9-rc3
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <200409300102.07373.gene.heskett@verizon.net> <415BA7D0.7070704@tequila.co.jp> <200409301627.20548.gene.heskett@verizon.net>
In-Reply-To: <200409301627.20548.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> bz2 has resulted in corrupted unpacks here on more than one occasion, 
> and it has done it without any outwardly visible error when the 
> md5sum was good.  I've had it skip a whole subdir tree in a kernel 
> unpack on at least 4 occasions, and a missing file someplace on 
> several more occasions.  I don't have any such troubles when dl'ing 
> and using the .gz version of things.
> 
> There has been at least one occasion where the .bz2 dl had a bad 
> md5sum, again without any visible error as it was downloading, nuke 
> it and go back and get the same file again and it was good.  Again 
> I've had no such troubles when using the .gz versions, so after a a 
> while, I got into the habit of just gettng the .gz version and I've 
> never had an instance of a bad md5sum that wasn't accompanied by site 
> access problems.


There's definitely something else going on.  I don't see how you can 
blame bz2 for downloading problems.  If this were true we would see a 
_lot_ more problem reports than just one in >5 years.

	Jeff


