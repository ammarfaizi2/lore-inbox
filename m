Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266673AbRGJRBq>; Tue, 10 Jul 2001 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266674AbRGJRBf>; Tue, 10 Jul 2001 13:01:35 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:22542 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S266673AbRGJRBV>; Tue, 10 Jul 2001 13:01:21 -0400
Message-ID: <3B4B34D9.8090203@interactivesi.com>
Date: Tue, 10 Jul 2001 12:01:13 -0500
From: Timur Tabi <ttabi@interactivesi.com>
Organization: Interactive Silicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <200107092129.QAA13628@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

>>So what are the limits without using PAE? Here I'm still having a little
>>problem finding definitive answers but ...
>>
>3 GB. Final answers are in the FAQ, and have been discussed before. You can
>also look in the Intel 80x86 CPU specifications.
>
>The only way to exceed current limits is via some form of segment register usage
>which will require a different compiler and a replacement of the memory
>architecture of x86 Linux implementation.
>

Are you talking about using 48-bit pointers?

(48-bit pointers, aka 16:32 pointers, on x86 are basically "far 32-bit 
pointers".  That is, each pointer is stored as a 48-bit value, where 16 
bits are for the selector/segment, and 32 bits are for the offset.

-- 
Timur Tabi
Interactive Silicon



