Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQKSMpZ>; Sun, 19 Nov 2000 07:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbQKSMpP>; Sun, 19 Nov 2000 07:45:15 -0500
Received: from new-smtp1.ihug.com.au ([203.109.250.27]:64008 "EHLO
	new-smtp1.ihug.com.au") by vger.kernel.org with ESMTP
	id <S129226AbQKSMpC>; Sun, 19 Nov 2000 07:45:02 -0500
Message-ID: <3A17C410.D80032AC@ihug.com.au>
Date: Sun, 19 Nov 2000 23:14:08 +1100
From: Vincent <dtig@ihug.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in test11-pre7 isofs/namei.c
In-Reply-To: <3A1674AF.B6127451@mountain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Leete wrote:
> 
> Hi,
> 
> The second and third arguments of get_joliet_filename() are swapped.
> 
> Tom
> 
> --- linux-2.4.0-test11/fs/isofs/namei.c.orig    Sat Nov 18 01:55:55 2000
> +++ linux-2.4.0-test11/fs/isofs/namei.c Sat Nov 18 07:08:05 2000
> @@ -127,7 +127,7 @@
>                         dpnt = tmpname;
>  #ifdef CONFIG_JOLIET
>                 } else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
> -                       dlen = get_joliet_filename(de, dir, tmpname);
> +                       dlen = get_joliet_filename(de, tmpname, dir);
>                         dpnt = tmpname;
>  #endif
>                 } else if (dir->i_sb->u.isofs_sb.s_mapping == 'a') {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
