Return-Path: <linux-kernel-owner+w=401wt.eu-S1030206AbWL3CKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWL3CKJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWL3CKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:10:09 -0500
Received: from main.gmane.org ([80.91.229.2]:36001 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030206AbWL3CKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:10:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Megacz <megacz@cs.berkeley.edu>
Subject: Re: OpenAFS gatekeepers request addition of AFS_SUPER_MAGIC to
 magic.h
Date: Fri, 29 Dec 2006 18:09:27 -0800
Organization: Myself
Message-ID: <x3wt4a16eg.fsf@nowhere.com>
References: <x3fyay2r4z.fsf@nowhere.com> <20061230004542.GJ24675@kenobi.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 216.237.119.187
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:nY2E+3951kRl4HSCqmtkKnVoVKk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drat.  Diffed in the wrong direction.  Yes, you're right.

  - a

Stephen Frost <sfrost@snowman.net> writes:
> * Adam Megacz (megacz@cs.berkeley.edu) wrote:
>> --- include/linux/magic.h       2006-12-29 15:48:50.000000000 -0800
>> +++ include/linux/magic.h       2006-11-29 13:57:37.000000000 -0800
>> @@ -3,7 +3,6 @@
>>  
>>  #define ADFS_SUPER_MAGIC       0xadf5
>>  #define AFFS_SUPER_MAGIC       0xadff
>> -#define AFS_SUPER_MAGIC                0x5346414F
>>  #define AUTOFS_SUPER_MAGIC     0x0187
>>  #define CODA_SUPER_MAGIC       0x73757245
>>  #define EFS_SUPER_MAGIC                0x414A53
>
> Wouldn't you want a patch which *adds* it, rather than one which
> *removes* it...?
>
> 	Thanks,
>
> 		Stephen

-- 
PGP/GPG: 5C9F F366 C9CF 2145 E770  B1B8 EFB1 462D A146 C380

