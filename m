Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDJUCN>; Tue, 10 Apr 2001 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRDJUCF>; Tue, 10 Apr 2001 16:02:05 -0400
Received: from sputnik.senv.net ([213.169.3.101]:7940 "HELO sputnik.senv.net")
	by vger.kernel.org with SMTP id <S132056AbRDJUBw>;
	Tue, 10 Apr 2001 16:01:52 -0400
Date: Tue, 10 Apr 2001 23:01:41 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.org>
X-X-Sender: <count@mir.senv.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: lockd trouble
In-Reply-To: <Pine.LNX.4.30.0104102137470.708-100000@mir.senv.net>
Message-ID: <Pine.LNX.4.33.0104102258040.3166-100000@mir.senv.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Jussi Hamalainen wrote:

>    program vers proto   port
>     100000    2   tcp    111  portmapper
>     100000    2   udp    111  portmapper
>     100021    1   udp   1024  nlockmgr
>     100021    3   udp   1024  nlockmgr
>     100005    1   udp    686  mountd
>     100005    2   udp    686  mountd
>     100005    1   tcp    689  mountd
>     100005    2   tcp    689  mountd
>     100003    2   udp   2049  nfs
>     100003    2   tcp   2049  nfs

Duhh. Obviously I should have read the documentation before bashing
my head against the wall. I wasn't running statd. Got it working now,
sorry about that.

I do have a question about lockd. How do I get it back if I need
to restart portmap? Running rpc.lockd doesn't seem to have any
effect whatsoever on the listed rpc services and I can't just
reload the module since nfs depends on it.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

