Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbSJFOZk>; Sun, 6 Oct 2002 10:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSJFOZj>; Sun, 6 Oct 2002 10:25:39 -0400
Received: from barnowl.demon.co.uk ([158.152.23.247]:59273 "EHLO
	home.gmurray.org.uk") by vger.kernel.org with ESMTP
	id <S261634AbSJFOZj> convert rfc822-to-8bit; Sun, 6 Oct 2002 10:25:39 -0400
Mail-Copies-To: nobody
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
References: <20021005090705.GA18475@stud.ntnu.no>
	<1033841462.1247.3716.camel@phantasy>
	<20021005182740.GC16200@vagabond>
	<20021005235614.GC25827@stud.ntnu.no>
	<20021006021802.GA31878@pegasys.ws>
	<1033871869.1247.4397.camel@phantasy>
	<20021006024902.GB31878@pegasys.ws>
	<20021006105917.GB13046@stud.ntnu.no>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: Sun, 06 Oct 2002 15:30:50 +0100
In-Reply-To: <20021006105917.GB13046@stud.ntnu.no> (Thomas
 =?iso-8859-1?q?Lang=E5s's?= message of "Sun, 6 Oct 2002 12:59:17 +0200")
Message-ID: <m3ptunej1h.fsf@home.gmurray.org.uk>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås <tlan@stud.ntnu.no> writes:

> They won't have any effect on the system, but the load number is
> insane (we have a 2 CPU intel-boks with a load number of 480)
> and there's like 200-300 (or more) processes hanging in D-state
> with they're FD's and stuff.

That in itself could have an effect on the system. Applications such
as sendmail and inn can monitor the load average and enter an
'overload' state (eg refuse connections) if it gets too high.
