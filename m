Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278189AbRJLWx4>; Fri, 12 Oct 2001 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278190AbRJLWxr>; Fri, 12 Oct 2001 18:53:47 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:34739 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S278189AbRJLWxa>; Fri, 12 Oct 2001 18:53:30 -0400
Date: Fri, 12 Oct 2001 15:28:55 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Wakko Warner <wakko@animx.eu.org>,
        Mike Panetta <mpanetta@applianceware.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org
Subject: Re: IDE Hot-Swap, does it work?, Conspiracy is afoot! (more questions)
Message-ID: <20011012152855.A6772@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	Pozsar Balazs <pozsy@sch.bme.hu>, Wakko Warner <wakko@animx.eu.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org
In-Reply-To: <20011012172955.B12857@animx.eu.org> <Pine.GSO.4.30.0110130008070.18155-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0110130008070.18155-100000@balu>; from pozsy@sch.bme.hu on Sat, Oct 13, 2001 at 12:14:01AM +0200
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 12:14:01AM +0200, Pozsar Balazs wrote:
> 
> I've been too asked this question two times in the list, and i haven't
> received any useful answer.
> 
> Wakko, could you tell me in detail how to use hdparm -R and -U, because i
> couldn't get it work. Does it (or shoudl it) work for harddisks too?
> 

I have been using this basic command form, but I think it may be
incorrect:

    hdparm -R [io addr ix hex] 0|[ctrl addr in hex] 0|[irq] /dev/hd?

if this is the wrong way to do it please tell me.

I am wondering how hard it would be to change the ioctl so
that it accepts an index, or nothing (it just scans) instead
of requiring the (sometimes hard to find) IO addres and such.
I know that the lagacy IO addresses never change, but the
PCI ones can be anything.  Or maybe this just does not work
with PCI IDE cards at all?  I do not know.

Thanks,
Mike

-- 
