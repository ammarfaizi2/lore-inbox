Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136244AbREJM4N>; Thu, 10 May 2001 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136247AbREJM4E>; Thu, 10 May 2001 08:56:04 -0400
Received: from darkstar.internet-factory.de ([195.122.142.9]:14029 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S136244AbREJMzw>; Thu, 10 May 2001 08:55:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: ECN: Volunteers needed
Date: Thu, 10 May 2001 14:55:51 +0200
Organization: Internet Factory AG
Message-ID: <3AFA8FD7.4B7C14A0@internet-factory.de>
In-Reply-To: <Pine.LNX.4.33.0105091559260.27312-100000@netcore.fi> <Pine.LNX.4.21.0105091249520.23642-100000@scotch.homeip.net> <9dbvh7$amg$1@cesium.transmeta.com>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 989499351 19167 195.122.142.158 (10 May 2001 12:55:51 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 10 May 2001 12:55:51 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac4 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> I suspect that the main way to get this thing fixed is to make sure
> ECN is enabled on the server side; for example, we have turned on ECN
> on kernel.org.  If a user is using a broken software stack, it's their
> loss, not ours.

This is what we do here, too. The only exceptions: Our mail server
(needs to deliver mail, even to broken sites) and our web proxy server
(also needs to connect to broken sites sometimes). Everything else is
ECN enabled. And this is the approach I'd suggest to anybody running 2.4
servers.

Holger
