Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRAKBtZ>; Wed, 10 Jan 2001 20:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbRAKBtQ>; Wed, 10 Jan 2001 20:49:16 -0500
Received: from james.kalifornia.com ([208.179.0.2]:43351 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130401AbRAKBtM>; Wed, 10 Jan 2001 20:49:12 -0500
Message-ID: <3A5D1112.66F64908@linux.com>
Date: Wed, 10 Jan 2001 17:49:06 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Ulrich Schwarz <uschwarz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 vm BUG (ksymoopsed)
In-Reply-To: <Pine.LNX.4.21.0101102121141.8803-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> > kernel BUG at vmscan.c:452!
> > invalid operand: 0000
>
> Does reiserfs patch changes vmscan.c ?
>
> If so, whats in line 452 of mm/vmscan.c of 2.4.0 reiserfs tree?

reiserfs doesn't touch mm/vmscan.c.

the line is: del_page_from_inactive_clean_list(page);

-d



> -- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
