Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCLJ2d>; Tue, 12 Mar 2002 04:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310507AbSCLJ2N>; Tue, 12 Mar 2002 04:28:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310504AbSCLJ2F>;
	Tue, 12 Mar 2002 04:28:05 -0500
Message-ID: <3C8DC9FC.7080004@mandrakesoft.com>
Date: Tue, 12 Mar 2002 04:27:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Ed Vance <EdV@macrolink.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial.c procfs 2nd try - discussion
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76EF@EXCHANGE> <20020312091144.A11914@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Mar 11, 2002 at 05:41:09PM -0800, Ed Vance wrote:
>
>>2. Does anybody know of anything that will break because of the leading 
>>   zeros that are now present on the address field? 
>>
>
>I'm not overly happy with this idea - there isn't anything that says an
>ioport address has 4 digits.  I know of machines where an ioport address
>has 8, and I'm sure on the Alpha or Sparc64 its probably 16 digits.
>
Agreed.  Standard portability convention seems to say that one treats io 
ports and io mem both as unsigned long, including when printing...

    Jeff




