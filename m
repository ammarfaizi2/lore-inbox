Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbRGJREP>; Tue, 10 Jul 2001 13:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266674AbRGJREF>; Tue, 10 Jul 2001 13:04:05 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:38926 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S266682AbRGJRDw>; Tue, 10 Jul 2001 13:03:52 -0400
Message-ID: <3B4B3570.9090104@interactivesi.com>
Date: Tue, 10 Jul 2001 12:03:44 -0500
From: Timur Tabi <ttabi@interactivesi.com>
Organization: Interactive Silicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org> <20010710011755.M18653@mea-ext.zmailer.org> <20010711014920.D31799@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>How does FreeBSD do this? What about other OSs? Do they map out most
>of userland on syscall entry and map it in as required for their
>equivalents to copy_to/from_user? (Taking the performance hit in doing
>so?)
>

I don't know about *BSD, but in Windows NT/2000, even drivers run in 
virtual space.  The OS is not monolithic, so address spaces are general 
not "shared" as they are in Linux.

-- 
Timur Tabi
Interactive Silicon



