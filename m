Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264557AbTCZC3V>; Tue, 25 Mar 2003 21:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264558AbTCZC3V>; Tue, 25 Mar 2003 21:29:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9450 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264557AbTCZC3U>;
	Tue, 25 Mar 2003 21:29:20 -0500
Message-ID: <3E81132C.9020506@pobox.com>
Date: Tue, 25 Mar 2003 21:40:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
References: <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
In-Reply-To: <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer wrote:
> "Justin Cormack wrote:"
>>And I am intending to write an iscsi client sometime, but it got
>>delayed. The server stuff is already available from 3com.
> 
> 
> Possibly, but ENBD is designed to fail :-). And networks fail.
> What will your iscsi implementation do when somebody resets the
> router? All those issues are handled by ENBD. ENBD breaks off and
> reconnects automatically. It reacts right to removable media.


Yeah, iSCSI handles all that and more.  It's a behemoth of a 
specification.  (whether a particular implementation implements all that 
stuff correctly is another matter...)

BTW, I'm a big enbd fan :)  I like enbd for it's _simplicity_ compared 
to iSCSI.

	Jeff



