Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292558AbSBZSCl>; Tue, 26 Feb 2002 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292557AbSBZSCg>; Tue, 26 Feb 2002 13:02:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292558AbSBZSCU>; Tue, 26 Feb 2002 13:02:20 -0500
Message-ID: <3C7BCD4A.9020400@zytor.com>
Date: Tue, 26 Feb 2002 10:00:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Rose, Billy" <wrose@loislaw.com>
CC: "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rose, Billy wrote:

> 
> My company can tolerate 0% loss of data (which is why I raised this issue).
> 


There is no such thing as 0% loss of data.  You can get some amount of 
security with backups, snapshots (really useful!) or undelete, but you 
can *NEVER* guarantee 0% loss of data... consider the case when a 
(l)user overwrites (not just deletes) a newly created file.

	-hpa


