Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTF2T10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTF2T10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:27:26 -0400
Received: from post.pl ([212.85.96.51]:42248 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S262116AbTF2T1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:27:25 -0400
Message-ID: <3EFF4177.6000705@post.pl>
Date: Sun, 29 Jun 2003 21:43:51 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl>
In-Reply-To: <3EFF3FFA.60806@post.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leonard Milcin Jr. wrote:
> If you have to change filesystem type, I think it is because you have a 
> good reason to do it. I can't imagine the reason explaining the need of 
> converting filesystem if you use this system as home desktop. For 
> ordinary user filesystem is just used for storing data and managing 
> permissions to that data. These are not real-time or 
> performance-critical systems. Thus most of the popular filesystems like 
> ext2, ext3, reiserfs basically fit their needs. If they choose right 
> filesystem type at startup, they could use it for a time of life of 
> their hard disk.
> 
> There are very few situations when you really need to convert 
> filesystem. Most of the time this operation is done by person who have 
> some experience with computers, and highly probable by person who has 
> access to additional hard disks, etc. I have never heard of one who had 
> to change filesystem type, and had no access to additional equipment.
> 
> I don't want to say it is not possible, to provide such a function 
> safely. What I want to say is that kernel developers should not 
> complicate filesystem code without *very* good reason. I think that 
> providing on-the-fly conversion capability is not a good reason. Good 
> reason is when you can improve usability for many users and most of the 
> time, not when you ease one operation needed by very few users few times 
> in their life, especially when they can do what they need by just 
> transferring their data back and forth to another disk, or machine.

Ok, I forgot about enterprise users with lots of data, and probably 
lacking free space, so I missed a point.

-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen

