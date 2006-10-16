Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWJPRKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWJPRKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWJPRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:10:36 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:6840
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161019AbWJPRKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:10:35 -0400
Message-ID: <4533BD1E.3080804@lsrfire.ath.cx>
Date: Mon, 16 Oct 2006 19:10:54 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to limit VFAT allocation?
References: <4533598A.3040909@dunaweb.hu> <200610161225.33190.prakash@punnoor.de> <4533658A.5030105@dunaweb.hu>
In-Reply-To: <4533658A.5030105@dunaweb.hu>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi schrieb:
> Prakash Punnoor írta:
>> Am Montag 16 Oktober 2006 12:06 schrieb Zoltan Boszormenyi:
>>  
>>> Is there a way to tell the VFAT driver to exclude
>>> the last N sectors from the allocation strategy?
>>>     
>>
>> Can't you mark that clusters as bad with a diskeditor?
>>   
> 
> Can you suggest one that works on Linux?
> Or which bits should I change if I use LDE?
> (lde.sourceforge.net)

Try mbadblocks, part of the Mtools package (http://mtools.linux.lu/).
If it doesn't help, and you are brave, you may want to play with
mdoctorfat, which comes with Mtools, too, but is hidden for some reason. :->

René
