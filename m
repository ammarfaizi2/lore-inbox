Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272121AbRH2W4j>; Wed, 29 Aug 2001 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272125AbRH2W4a>; Wed, 29 Aug 2001 18:56:30 -0400
Received: from [208.48.139.185] ([208.48.139.185]:42115 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272121AbRH2W4V>; Wed, 29 Aug 2001 18:56:21 -0400
Date: Wed, 29 Aug 2001 15:56:33 -0700
From: David Rees <dbr@greenhydrant.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829155633.D21590@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <3B8D54F3.46DC2ABB@zip.com.au>, <3B8D54F3.46DC2ABB@zip.com.au>; <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au>, <3B8D60CF.A1400171@zip.com.au>; <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au>, <3B8D6BF9.BFFC4505@zip.com.au>; <20010829153818.B21590@greenhydrant.com> <3B8D712C.1441BC5A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8D712C.1441BC5A@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 03:48:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 03:48:12PM -0700, Andrew Morton wrote:
> David Rees wrote:
>
> Are you able to access all the underlying devices on the array?
> For example, if /dev/md0 consists of /dev/hda1 and /dev/hdb2,
> can you run 'cp /dev/hda1 /dev/null' and 'cp /dev/hdb1 /dev/null'?
> 
> If so, then I'm all out of ideas.  Your raid1 buffers have disappeared
> into thin air :(

Copying as I write this (actually, `cat /dev/hde1 > /dev/null` and `cat
/dev/hdg1 >/dev/null`.

Well, if no-one knows, I'll reboot and cross my fingers that it doesn't
happen again.

Thanks,
Dave
