Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129926AbRB0XYF>; Tue, 27 Feb 2001 18:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbRB0XXz>; Tue, 27 Feb 2001 18:23:55 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:30760 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129926AbRB0XXk>; Tue, 27 Feb 2001 18:23:40 -0500
Message-ID: <3A9C36BF.6060608@blue-labs.org>
Date: Tue, 27 Feb 2001 15:22:39 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac3 i686; en-US; 0.9) Gecko/20010225
X-Accept-Language: en
MIME-Version: 1.0
To: Alistair Riddell <ali@gwc.org.uk>
CC: "Heusden, Folkert van" <f.v.heusden@ftr.nl>,
        Ivo Timmermans <irt@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <Pine.LNX.4.21.0102271425200.14871-100000@frank.gwc.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Riddell wrote:

> On Tue, 27 Feb 2001, Heusden, Folkert van wrote:
> 
>> But; it's not that much of hassle to run it trough some awk/sed/whatsoever
>> script, would it? Imho there should be as less as possible code in the
> 
> 
> man fromdos (on most linux systems anyway)
> 

tr -d '\r' < infile > outfile

We wouldn't make the kernel translate m$ word docs into files the kernel 
can parse.  It's a userland thing and changing the kernel would change a 
legacy that would cause a lot of confusion I would expect.

-d

