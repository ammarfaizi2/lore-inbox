Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbRGQCht>; Mon, 16 Jul 2001 22:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbRGQChj>; Mon, 16 Jul 2001 22:37:39 -0400
Received: from c008-h000.c008.snv.cp.net ([209.228.34.63]:41465 "HELO
	c008.snv.cp.net") by vger.kernel.org with SMTP id <S267748AbRGQChV>;
	Mon, 16 Jul 2001 22:37:21 -0400
X-Sent: 17 Jul 2001 02:37:18 GMT
Message-ID: <3B53A4D8.A9613CFF@acm.org>
Date: Tue, 17 Jul 2001 12:37:12 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu>	<3B532BB7.1050300@valinux.com> <3B533578.A4B6C25F@damncats.org> 	<3B53413A.6060501@valinux.com> <995312089.987.8.camel@nomade> <3B534C1F.8080100@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> 
> You have to remember this isn't an API that users program to, it is an
> API that a specific driver uses.  Each driver is different, and has a
> different API (at least a subset of it.)  The cards are so different
> that they can't have the same interfaces and remain competitive.  Each
> 3D client side driver packages up state and vertex data in a form that
> only that video card can understand.  Each new drm kernel driver
> requires a new device specific portion of the API.

Exactly.  I don't think of it as an API in the true meaning of the
term.  No one other than that specific driver should (can?) even use it.

> If we want to be secure, we have to have an interface which can remain
> competitive with insecure drivers.

Exactly.  I know myself and Keith Whitwell in particular have put a lot
of effort into making the open source drivers at least in the same
ballpark of performance as their Win32 counterparts.  People will never
seriously use Linux for 3D if performance just plain sucks.  Now, at
least they have the option of buying an NVIDIA card...

-- Gareth
