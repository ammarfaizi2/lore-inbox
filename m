Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292633AbSBZSRM>; Tue, 26 Feb 2002 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292638AbSBZSRH>; Tue, 26 Feb 2002 13:17:07 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:11249 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292648AbSBZSQF>;
	Tue, 26 Feb 2002 13:16:05 -0500
Date: Tue, 26 Feb 2002 11:15:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rose, Billy" <wrose@loislaw.com>,
        "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226111509.J12832@lynx.adilger.int>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	"Rose, Billy" <wrose@loislaw.com>,
	'Martin Dalecki' <dalecki@evision-ventures.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com> <3C7BCD4A.9020400@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7BCD4A.9020400@zytor.com>; from hpa@zytor.com on Tue, Feb 26, 2002 at 10:00:42AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  10:00 -0800, H. Peter Anvin wrote:
> Rose, Billy wrote:
> > My company can tolerate 0% loss of data (which is why I raised this issue).
> 
> There is no such thing as 0% loss of data.  You can get some amount of 
> security with backups, snapshots (really useful!) or undelete, but you 
> can *NEVER* guarantee 0% loss of data... consider the case when a 
> (l)user overwrites (not just deletes) a newly created file.

Snapshots at the filesystem level could handle the overwrite case.

However, even then it cannot be 0% loss of data, unless you have snapshots
for _every_ write of the file, which would quickly become prohibitive in
space usage (think autobackup from an editor on a large file).  Sometimes
people just have to learn from their mistakes...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

