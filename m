Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRFYODe>; Mon, 25 Jun 2001 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRFYODO>; Mon, 25 Jun 2001 10:03:14 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:29161 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S264381AbRFYODE>; Mon, 25 Jun 2001 10:03:04 -0400
Date: Mon, 25 Jun 2001 09:59:32 -0400
From: Alan Shutko <ats@acm.org>
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <87ofrcbryf.fsf@wesley.springies.com>
To: root@chaos.analogic.com
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Message-id: <87g0cobrgz.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.103
In-Reply-To: <Pine.LNX.3.95.1010625072259.5434A-100000@chaos.analogic.com>
 <87ofrcbryf.fsf@wesley.springies.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Shutko <ats@acm.org> writes:

> You can look at other things too... you can memcpy structures, pass
> them into functions, call sizeof, put them in arrays... it _is_ a
> physical representation.

One more tidbit: ISO/IEC 9899:1990 3.14

  3.14 object: A region of data storage in the execution environment,
    the contents of which can represent values.  Except for
    bit-fields, objects are composed of contiguous sequences of one or
    more bytes, the number, order and encoding of which are either
    explicitely specified or implementation-defined.

This would specifically prohibit separating any part of a structure
from the rest.

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
A king's castle is his home.
