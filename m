Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRAKRQw>; Thu, 11 Jan 2001 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAKRQk>; Thu, 11 Jan 2001 12:16:40 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:37882 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S130230AbRAKRQ3>; Thu, 11 Jan 2001 12:16:29 -0500
From: junio@siamese.dhis.twinsun.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Floating point broken between 2.4.0-ac4 and -ac5?
In-Reply-To: <E14Gh42-00029E-00@the-village.bc.nu>
    <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De>
Date: 11 Jan 2001 09:16:18 -0800
In-Reply-To: <E14Gh42-00029E-00@the-village.bc.nu>
Message-ID: <7vzogyko0t.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AC" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> A Duron box running 2.4.0-ac5 (and -ac6) shows NaN in many
>> places (such as df output showing usage "nan%").  Right now I
>> reverted back to 2.4.0-ac4 which does not show the problem.
>> The kernel was compiled with CONFIG_MK7 and without
>> MATH_EMULATION, if that makes any difference.

AC> If you boot with the nofxsr option does that fix the problem ?

Yes, it seems to fix it.  I guess this is the same problem as
Udo A Steinberg has reported earlier in ``XFree 4.0.2 and "w"''
thread Message-ID: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De>.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
