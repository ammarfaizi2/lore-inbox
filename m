Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292660AbSCDSf0>; Mon, 4 Mar 2002 13:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSCDSfN>; Mon, 4 Mar 2002 13:35:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292665AbSCDSdw>; Mon, 4 Mar 2002 13:33:52 -0500
Message-ID: <3C83BE05.6060600@zytor.com>
Date: Mon, 04 Mar 2002 10:33:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <200203041834.NAA03295@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

> hpa@zytor.com said:
> 
>>I think it's you -- you seem to suffer from the "my application is the
>>only one that counts" syndrome.  If you want to pages dirtied, then
>>dirty them using memset() or similar. 
>>
> 
> I think you and Alan think I want the host kernel to do the dirtying.  Not so,
> I want no changes on the host.  I want a hook that UML can use to make sure
> that all pages that it allocates are backed.
> 
> And memset or something similar is exactly what I have in mind.
> 


So why, then, phrase this as a feature request???

	-hpa


