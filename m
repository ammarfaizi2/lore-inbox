Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSFRTfS>; Tue, 18 Jun 2002 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFRTfQ>; Tue, 18 Jun 2002 15:35:16 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:33408 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317581AbSFRTdz>; Tue, 18 Jun 2002 15:33:55 -0400
Date: Tue, 18 Jun 2002 21:39:00 +0200
Organization: Pleyades
To: adilger@clusterfs.com, austin@digitalroadkill.net
Subject: Re: Shrinking ext3 directories
Cc: raul@pleyades.net, linux-kernel@vger.kernel.org
Message-ID: <3D0F8C54.mailH8O37ZVW5@viadomus.com>
References: <3D0F5AFC.mailGSE111D9L@viadomus.com>
 <1024416626.7681.39.camel@UberGeek>
 <20020618163947.GO22427@clusterfs.com>
In-Reply-To: <20020618163947.GO22427@clusterfs.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andreas :)

>> >     Any other way of doing the same without the mess?
>Not right now.  Truncating directories on a mounted filesystem is
>probably going to be a big source of strange problems.

    So I'd better go with the move-and-rename alternative...

>In the end it isn't really a problem for most people, because if
>your directory has grown big once it is likely to grow big again.

    Well, my problem arose just a couple of times, when by mistake I
extract a tarball in a directory, or by a wrong 'touch' command
(related to some bad use of 'seq'), etc... Not a problem at all, but
curiosity about this.

>With htree directories we will have to make this work at some point,

    Ok, I'll take a look then :)) Thanks for answering :)
    Raúl
