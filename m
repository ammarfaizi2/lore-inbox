Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292612AbSBZSXc>; Tue, 26 Feb 2002 13:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292650AbSBZSWz>; Tue, 26 Feb 2002 13:22:55 -0500
Received: from [208.29.163.248] ([208.29.163.248]:22199 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S292658AbSBZSVm>; Tue, 26 Feb 2002 13:21:42 -0500
Date: Tue, 26 Feb 2002 10:19:47 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: "Rose, Billy" <wrose@loislaw.com>,
        "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
In-Reply-To: <3C7BCD4A.9020400@zytor.com>
Message-ID: <Pine.LNX.4.44.0202261018110.13806-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, if they run everything on worm drives or setup a filesystem that
never overwrites blocks, only allocates new ones (and never has a hardware
failure) and are willing to buy huge amounts of storage, it's possible,
but the cost (if only for installing all the new disk drives) would be
huge.

David Lang


 On Tue, 26 Feb 2002, H. Peter Anvin wrote:

> Date: Tue, 26 Feb 2002 10:00:42 -0800
> From: H. Peter Anvin <hpa@zytor.com>
> To: "Rose, Billy" <wrose@loislaw.com>
> Cc: 'Martin Dalecki' <dalecki@evision-ventures.com>,
>      Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
> Subject: Re: ext3 and undeletion
>
> Rose, Billy wrote:
>
> >
> > My company can tolerate 0% loss of data (which is why I raised this issue).
> >
>
>
> There is no such thing as 0% loss of data.  You can get some amount of
> security with backups, snapshots (really useful!) or undelete, but you
> can *NEVER* guarantee 0% loss of data... consider the case when a
> (l)user overwrites (not just deletes) a newly created file.
>
> 	-hpa
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
