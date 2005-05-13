Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVEMHuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVEMHuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVEMHuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:50:15 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:154 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262281AbVEMHuJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:50:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SBpHB49GLwj/6dl7Tv6PkDQGZuDHLsLD75CP9b3vbrU+ZAnkih2WgMWG/ZxxrVEL/XDyTMfXa2KMEmxJqRTFFpr6y4nwtXsAm79i1tyS3AUTvcBZYmR0r0Z2u0epvq8jFBk6pRs3l48irZlCm7HjYeDJkmlzgSVGLm0E1BGDV9c=
Message-ID: <3cac075b050513005076db4b87@mail.gmail.com>
Date: Fri, 13 May 2005 12:50:09 +0500
From: Nauman <mailtonauman@gmail.com>
Reply-To: Nauman <mailtonauman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT2-FS Error (ext2_new_block) Where is this comming from?? can anyone help
In-Reply-To: <3cac075b05050423135a8efa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3cac075b05050423135a8efa2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for ur reply Honza , 
that problem was solved .. that was my own kernel hack. and was due to
some calculation bugs
 :)
Nauman

On 5/5/05, Nauman <mailtonauman@gmail.com> wrote:
> Dear linux gurus,
> I have set up a Block Device over a SCSI drive. I write data to the
> actual target drive after writing same blocks in my RAMDISK. I am
> using RAMDISK of 2 GB. once the allcoated blocks of my RAMDISK are
> full i start freeing those blocks (WRITE THROUGH). at  this point i
> get this message during Write operations
> Ext2 FS- Error: ext2_new_block : Allocating blocks in System zone. <block_nr>
> Is this some sort of calculation error or some other configuration problem??
> 
> --
> When the going gets tough, The tough gets going...!
> Peace ,
> Nauman.
> 


-- 
When the going gets tough, The tough gets going...!
Peace ,  
Nauman.
