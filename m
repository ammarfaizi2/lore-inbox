Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRC0Alf>; Mon, 26 Mar 2001 19:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRC0Al0>; Mon, 26 Mar 2001 19:41:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53769 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129854AbRC0AlL>; Mon, 26 Mar 2001 19:41:11 -0500
Message-ID: <3ABFE145.F2C3FA28@uow.edu.au>
Date: Tue, 27 Mar 2001 00:39:33 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Zephaniah E. Hull" <warp@whitestar.soark.net>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Lovely crash with 2.4.2-ac24.
In-Reply-To: <20010326132833.B3920@whitestar.soark.net> <Pine.LNX.4.10.10103261030570.14541-100000@master.linux-ide.org> <20010326140349.D3920@whitestar.soark.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zephaniah E. Hull" wrote:
> 
> [-ac24 crash]

Guys, this is related to the tty hangup code calling the
console code in interrupt context.  Fixed in -ac25.  The
IDE connection is just stack fluff.
