Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTEEO4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEEO4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:56:25 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:60164 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262293AbTEEO4Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:56:24 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Zeev Fisher <Zeev.Fisher@il.marvell.com>
Subject: Re: processes stuck in D state
Date: Mon, 5 May 2003 16:56:20 +0200
User-Agent: KMail/1.5.1
References: <3EB5FC05.5080003@il.marvell.com>
In-Reply-To: <3EB5FC05.5080003@il.marvell.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051656.32048.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 07:52, Zeev Fisher wrote:
> Hi!

Hi Zeev!

> I got a continuos problem of unkillable processes stuck in D state (
> uninterruptable sleep ) on my Linux servers.
> It happens randomly every time on other server on another process ( all
> the servers are configured the same with 2.4.18-10 kernel ). Here's an
> example :
[snip]
> Has anyone noticed the same behavior ? Is this a well known problem ?

I've had the same problem with some 2.4.21-preX twice (or maybe more times,
don't remember) on one of my machines.
IMHO it has something to do with NFS. (I'm using this box as a NFS-client).
I wish, I could reproduce it one more time, to do some traces, etc
on it. But I've not found a way to reproduce it, yet.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 16:50:44 up 52 min,  1 user,  load average: 1.00, 1.00, 0.94
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tnugoxoigfggmSgRAt8BAJ0deufnL/E6acpz4pIPZll8f48TIgCfWmcI
auSRmi6oyrTbqMVe+MrfuV4=
=ahIZ
-----END PGP SIGNATURE-----

