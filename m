Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbTCKMrf>; Tue, 11 Mar 2003 07:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbTCKMrf>; Tue, 11 Mar 2003 07:47:35 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13576 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262914AbTCKMre>; Tue, 11 Mar 2003 07:47:34 -0500
Message-ID: <3E6DDDD2.3050709@aitel.hist.no>
Date: Tue, 11 Mar 2003 14:00:02 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improved inode number allocation for HTree
References: <11490000.1046367063@[10.10.2.4]> <20030310204146.875D3F0D4D@mx12.arcor-online.net> <3E6D1D25.5000004@namesys.com> <20030311031216.8A31CEFD5F@mx12.arcor-online.net> <3E6DBE3B.8030007@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Let's make noatime the default for VFS.
> 
> Daniel Phillips wrote:
[...]
>> If I were able to design Unix over again, I'd state that if you don't 
>> lock a directory before traversing it then it's your own fault if 
>> somebody changes it under you, and I would have provided an interface 
>> to inform you about your bad luck.  Strictly wishful thinking.  
>> (There, it feels better now.)

I'm happy nobody _can_ lock a directory like that.  Think of it - unable
to create or delete files while some slow-moving program is traversing
the directory?  Ouch.  Plenty of options for DOS attacks too.
And how to do "rm *.bak" if rm locks the dir for traversal?

Helge Hafting

