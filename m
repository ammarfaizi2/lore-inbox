Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290807AbSBFVCM>; Wed, 6 Feb 2002 16:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290808AbSBFVCD>; Wed, 6 Feb 2002 16:02:03 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:11247 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290807AbSBFVBx>; Wed, 6 Feb 2002 16:01:53 -0500
Message-ID: <3C619927.2020601@wanadoo.fr>
Date: Wed, 06 Feb 2002 21:59:19 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr> <3C619586.92EAED50@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pierre Rousselet wrote:
> 
>>Patching drivers/char/gameport with /dev/null doesn't work for me. What
>>is the trick ?
>>
> 
> /dev/null indicates a new, or a removed, file.

'patch -p0 < patch' is confused by this : "sure you want to delete this 
file ?"

Are there some arguments to add on the cmd line ?

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

