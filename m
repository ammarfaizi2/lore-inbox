Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWEHVRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWEHVRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWEHVRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:17:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:10546 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750866AbWEHVRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:17:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c02uSAhczUwpvu7TaI7m35GrvesMxXotnlk+WZW3tezxnzXSTu2Tq6reln1+aMPuwNGT0xvdpm8ugd0ImmKKcSiTyi4BaCR+mvKxjLtTIftrg7e2l8HiheUMe376QhSGYPL53svrod6I98ld5t6+bMfE7HsEdATOe1Acn4m48eM=
Message-ID: <64b292120605081417y1684cba4kfb85ce39c14df0f7@mail.gmail.com>
Date: Mon, 8 May 2006 16:17:07 -0500
From: "Circuitsoft Development" <circuitsoft.devel@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Fwd: Fwd: Extended Volume Manager API
In-Reply-To: <64b292120605062123gdb302d2g201fa59e93bc6a25@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com>
	 <200605010702.k4172Q5H006348@turing-police.cc.vt.edu>
	 <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com>
	 <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com>
	 <Pine.LNX.4.64.0605020842250.29285@cuia.boston.redhat.com>
	 <64b292120605062123gdb302d2g201fa59e93bc6a25@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Rik van Riel <riel@redhat.com> wrote:
> On Mon, 1 May 2006, Circuitsoft Development wrote:
>
> > I was actually planning on a 5msec timeout to ignore that computer,
> > for now, then if I don't get a response within 100msec,  ping them,
> > and permenantly remove them from the list of peers and broadcast a
> > "this peer is dead" message to the network if the ping times out at
> > 500msec.
>
> How are you going to prevent your "dead" peer from writing
> to the disk anyway ?
>
> --
> All Rights Reversed
>

I'm not. They also need to get permission from the network before they
write to the disk, and they're not going to get permission without
hearing back from everybody. Besides, since the same network is used
to connect to the disks as is used to connect the computers to each
other, how would it be able to access the disks without being able to
access other computers which also connect to the disks?

(Sorry for the repeat, Rik)
