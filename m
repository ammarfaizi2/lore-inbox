Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSIBED0>; Mon, 2 Sep 2002 00:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIBED0>; Mon, 2 Sep 2002 00:03:26 -0400
Received: from p508B6F8E.dip.t-dialin.net ([80.139.111.142]:20867 "EHLO
	p508B6F8E.dip.t-dialin.net") by vger.kernel.org with ESMTP
	id <S318221AbSIBEDZ>; Mon, 2 Sep 2002 00:03:25 -0400
Date: Mon, 2 Sep 2002 06:07:49 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: dirty boy <slashdotcommacolon@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux ELF Implementation
Message-ID: <20020902060749.A6109@bacchus.dhis.org>
References: <F218kOUkl2SN8anK0B30000890f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F218kOUkl2SN8anK0B30000890f@hotmail.com>; from slashdotcommacolon@hotmail.com on Sun, Sep 01, 2002 at 10:26:10PM +0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 10:26:10PM +0000, dirty boy wrote:

> im learning about the ELF specification with a friend of mine, were hoping 
> to get a better understanding of how these things work, and a wild idea 
> occurred to us - would it be possible to create a valid ELF executable from 
> purely printable ASCII characters ?
> 
> by that i mean, you would be able to literally cat > a.out and enter your 
> executable from the keyboard! it wouldnt have todo anything, just return 
> 0...
> 
> the file wouldnt have to be portable, only the fields that the kernel is 
> going to notice would have to be present, so long as it executes!
> 
> im convinced the answer is no - but my friend says it is, he says hes seen 
> it done in PE format ( although we cant find it on the web ) and therefore 
> theres no reason why it couldnt be done in ELF.

There answer is no; the ELF magic at the begin of an ELF file contains
a non-printable character.

  Ralf
