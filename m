Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLJP1B>; Tue, 10 Dec 2002 10:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSLJP1B>; Tue, 10 Dec 2002 10:27:01 -0500
Received: from unthought.net ([212.97.129.24]:9653 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262360AbSLJP07>;
	Tue, 10 Dec 2002 10:26:59 -0500
Date: Tue, 10 Dec 2002 16:34:42 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID5 chunksize?
Message-ID: <20021210153442.GB28095@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021210152330.GP32203@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021210152330.GP32203@rdlg.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 10:23:30AM -0500, Robert L. Harris wrote:
> 
> 
> Ok, say I'm building a 4 disk raid5 array.  Performance is going to be
> critical as this system is going to be very IO intensive.  We had to go
> RAID5 though due to filesystem requirements.
> 
> According to the manufacturer the disks have:
> 
>   8Meg DataBuffer
>   10K RPM Rotational speed
>   SCSI Ultra 160
> 
> (Drive is:
> http://www.fel.fujitsu.com/home/product.asp?L=en&PID=248&INFO=fsp)
> 
> What is the ideal Chunksize?  

Measure.

Try 4k, 32k, 128k, and see which is best.

Please post the results to the list  :)

It is important that you benchmark not with tiotest or bonnie, but with
the actual applications that need to use this server.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
