Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDXLVg>; Wed, 24 Apr 2002 07:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSDXLVf>; Wed, 24 Apr 2002 07:21:35 -0400
Received: from [159.226.41.188] ([159.226.41.188]:64012 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S311647AbSDXLVe>; Wed, 24 Apr 2002 07:21:34 -0400
Date: Wed, 24 Apr 2002 19:20:46 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: Andreas Dilger <adilger@clusterfs.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: your mail
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE2B927.AAA1AE6@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  No thread and timer associated with it.
  I am a kernel newbie. I just managed to make the module's release function to cope with "ctrl+c", nothing more is done. I do not know how to impove my code to make it cope with the TERM signal(No. 15 signal ?). In closing the dev file of a device, IMHO, all signal trigger the same function.
 
>On Apr 24, 2002  17:44 +0800, Huo Zhigang wrote:
>>   Remove the driver first befor reboot! It works. But what is relation
>> between the reboot process and my driver? When I remove the driver module
>> myself, nothing goes wrong. What is the difference?
>
>Does your module have a timer or thread which may be active at shutdown?
>It may be that if it has a kernel thread that the TERM will kill the
>thread and your driver does not expect this.
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>http://sourceforge.net/projects/ext2resize/


