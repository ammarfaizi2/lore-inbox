Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSAPVFA>; Wed, 16 Jan 2002 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSAPVEs>; Wed, 16 Jan 2002 16:04:48 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:62730 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S287633AbSAPVE2>;
	Wed, 16 Jan 2002 16:04:28 -0500
Date: Wed, 16 Jan 2002 13:38:30 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <20020116195105.C18039@devcon.net>
Message-ID: <Pine.LNX.4.21.0201161335500.27780-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Andreas Ferber wrote:

> And some wishlist items:
> 
> - It would be nice if there were a way to distinguish between TCP and
>   UDP ports.
> - IPv6 support would be nice. This raises the question what will
>   happen if a process has the privileges to bind a particular port
>   with IPv6 but not with IPv4 (IPv6 listeners take IPv4 connections
>   also). Is there any value in distinguishing IPv6 and IPv4 at all,
>   in particular if IPv6 gets into more widespread use in the future?
> - Restricting access to certain high ports would be valuable. For
>   example many SQL server use those ports, and it would be nice if one
>   could prevent ordinary user processes from taking over their ports
>   in case the SQL daemon gets restarted or the like.
> 
> At least accessfs is a nice and expandable idea. Keep up the work :-)
> 

What would be nice would be to have a way to restrict access to ports
based on IP ex: user1 gets 10.0.0.1 and user2 gets 10.0.0.2.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

