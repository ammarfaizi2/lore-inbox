Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290966AbSBGAOc>; Wed, 6 Feb 2002 19:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290981AbSBGAOO>; Wed, 6 Feb 2002 19:14:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290966AbSBGAOB>; Wed, 6 Feb 2002 19:14:01 -0500
Message-ID: <3C61C6A3.6040200@zytor.com>
Date: Wed, 06 Feb 2002 16:13:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: jakub@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <E16YcJW-0006vG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>This is not possible, since then %gs:0 (which is TLS base) cannot be read.
>>We would have to change the TLS ABI (thus become incompatible e.g. with Sun)
>>
> 
> Sun who have canned their x86 product it seems. I don't feel "the standard
> requires we suck" is an appropriate justification for anything. If there 
> is not a sane way to follow the standard - break it. If there is a sane way
> then all fair and good, find it and use it
> 


I do have to agree that zero-basing the TLS pointer seems saner than not
doing so.

	-hpa


