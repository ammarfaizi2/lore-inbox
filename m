Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSGXTEO>; Wed, 24 Jul 2002 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317551AbSGXTEO>; Wed, 24 Jul 2002 15:04:14 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:9176 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317549AbSGXTEO>; Wed, 24 Jul 2002 15:04:14 -0400
Message-ID: <3D3EFAD4.C1D2DE4A@nortelnetworks.com>
Date: Wed, 24 Jul 2002 15:07:00 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The thing is, we cannot change existing select semantics, and the question
> is whether what most soft-realtime wants is actually select, or whether
> people really want a "waittimeofday()".

Actually, I'd like a
waitonmonotonicallyincreasingnonadjustablehighres64bittime().

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
