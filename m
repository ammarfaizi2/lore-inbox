Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbTCHWG0>; Sat, 8 Mar 2003 17:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCHWG0>; Sat, 8 Mar 2003 17:06:26 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:54195 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S262229AbTCHWGZ>; Sat, 8 Mar 2003 17:06:25 -0500
Date: Sat, 8 Mar 2003 14:16:51 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308221651.GL2835@ca-server1.us.oracle.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <20030308214130.GK2835@ca-server1.us.oracle.com> <20030308215239.A782@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308215239.A782@infradead.org>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 09:52:39PM +0000, Christoph Hellwig wrote:
> What hack to steal every remaining major?  Remember that Linus already said
> that there won't be new static majors anyway.

	Having more than one major for disks is a hack.  Already.

> were do you get this 4000 disks number from?  Every big system in practice
> is attached to some EMC/LSI/IBM/whatever array anyway that virtualizes
> away the actual disk.

	We've already got systems with 4000 disks attached.  Registered
with the system, even.  This isn't hiding behind some big array.  They
are part of the system.  No, it's not on Linux, because Linux can't
handle it.  But if the system wants to go Linux, Linux has to handle it.
And 1900 disks wont' cut it *today*.  Never mind 2 years from now.

Joel

-- 

Life's Little Instruction Book #80

	"Slow dance"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
