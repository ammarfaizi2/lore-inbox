Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131122AbRBTXjW>; Tue, 20 Feb 2001 18:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbRBTXjM>; Tue, 20 Feb 2001 18:39:12 -0500
Received: from inspiron.swusa.com ([207.214.125.61]:35467 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S131122AbRBTXif>;
	Tue, 20 Feb 2001 18:38:35 -0500
Message-ID: <20010220153845.A29633@saw.sw.com.sg>
Date: Tue, 20 Feb 2001 15:38:45 -0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: vido@ldh.org
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
In-Reply-To: <20010212133248.A7147@saw.sw.com.sg> <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu> <20010220153048.A26551@ldh.org> <20010219232136.C26553@saw.sw.com.sg> <20010220171837.A26967@ldh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010220171837.A26967@ldh.org>; from "Augustin Vidovic" on Tue, Feb 20, 2001 at 05:18:37PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 05:18:37PM +0900, Augustin Vidovic wrote:
> 00:0c.0 Ethernet controller: Intel Corporation 82557 (rev 08)
> 00:0d.0 Ethernet controller: Intel Corporation 82557 (rev 08)

It's i82559.
It can't have that original bug which is checked by those EEPROM bits and
workaround for which is implemented.
You probably have another one :-)

What are the symptomes of the lock-ups?
Does TX timeout happen?
Does the card recover and resume operations after that?

Best regards
		Andrey
