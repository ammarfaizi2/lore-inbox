Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbTCLXC6>; Wed, 12 Mar 2003 18:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTCLXC4>; Wed, 12 Mar 2003 18:02:56 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:5521 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S262096AbTCLXCw>; Wed, 12 Mar 2003 18:02:52 -0500
Message-ID: <3E6FBF15.6080904@bogonomicon.net>
Date: Wed, 12 Mar 2003 17:13:25 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andre@linux-ide.org
Subject: Re: time loss using ide-scsi under 2.4.21-pre5-ac2
References: <200303122246.h2CMkf519689@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I'm seeing seconds of time loss per minute while ripping CDs via grip 
>>and it's internal cdparanoia.  Grip uses the scsi generic device for 
> 
> 
> hdparm -u1 

That fixed it.

- Bryan



