Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbRFSVJa>; Tue, 19 Jun 2001 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264789AbRFSVJU>; Tue, 19 Jun 2001 17:09:20 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:11019 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264786AbRFSVJC>;
	Tue, 19 Jun 2001 17:09:02 -0400
Message-ID: <3B2FBF76.40993998@bigfoot.com>
Date: Tue, 19 Jun 2001 15:09:10 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Still some problems with UHCI driver in 2.4.5 on VIA chipsets
In-Reply-To: <3B2D446A.5C2AEEAC@bigfoot.com> <20010617200855.R9465@sventech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
> Could you load uhci with the debug=1 option?

I did an 'insmod uhci.o debug=1' but the dmesg output did not alter.

My easy steps to reproduce it is to 'delete selected images' in gphoto such
that there will be no images in the camera left when the operation is done. 
At loast it doesn't lock up the camera like it used to :-/

I think this may be a problem in the dc2xx.o then, since uhci didn't reveal
any new messages.

--
    www.kuro5hin.org -- technology and culture, from the trenches.
