Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRKTUhu>; Tue, 20 Nov 2001 15:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281369AbRKTUhj>; Tue, 20 Nov 2001 15:37:39 -0500
Received: from tbird2.auc.ca ([199.212.53.2]:6149 "HELO tbird2.auc.on.ca")
	by vger.kernel.org with SMTP id <S281360AbRKTUhX>;
	Tue, 20 Nov 2001 15:37:23 -0500
Subject: Re: File size limit exceeded with mkfs
From: Jason Tackaberry <tack@auc.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011120113316.R1308@lynx.no>
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca> 
	<20011120113316.R1308@lynx.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 20 Nov 2001 15:29:14 -0500
Message-Id: <1006288154.1863.0.camel@somewhere.auc.ca>
Mime-Version: 1.0
X-Spam-Rating: tbird2.auc.ca 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, 2001-11-20 at 13:33, Andreas Dilger wrote:
> Several people have reported problems like this also.  What happens is
> that if you are logged on as a user, then su to root, it will fail.  If
> you log in directly as root, it will work.

Yep, this is indeed the case.

> Can you please try some intermediate kernels (2.4.10 would be a good
> start, because it had some major changes in this area, and then go
> forward and back depending whether it works or not).

2.4.10 does NOT work.
2.4.9 DOES work.

So clearly something happened in 2.4.10 which broke this.  Please let me
know if I can be of any more help.

Regards,
Jason.

