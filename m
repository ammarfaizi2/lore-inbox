Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSHWHIZ>; Fri, 23 Aug 2002 03:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSHWHIZ>; Fri, 23 Aug 2002 03:08:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:27659 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318514AbSHWHIT>; Fri, 23 Aug 2002 03:08:19 -0400
Message-ID: <3D65E0DA.750FAA04@aitel.hist.no>
Date: Fri, 23 Aug 2002 09:14:34 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208222016350.13077-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Oh and it is only useful for borken things like LINBIOS and other
> braindead systems like ARM that violate the 31 second rule of POST.
> 
31s of POST is uselessly slow.  Perhaps it is needed when
the drives _are_ spinning up, but not for the common
case of rebooting to activate a new kernel
(or reset button when the dev-kernel hung.)  The disk
is spinning already in those cases, and there should 
be no bootup delay.

Helge Hafting
