Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbREPHYN>; Wed, 16 May 2001 03:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbREPHXy>; Wed, 16 May 2001 03:23:54 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:61968 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261809AbREPHXq>; Wed, 16 May 2001 03:23:46 -0400
Date: 16 May 2001 09:11:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80x0jOtXw-B@khms.westfalen.de>
In-Reply-To: <3B01A044.F72BFDD1@transmeta.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com> <3B01A044.F72BFDD1@transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@transmeta.com (H. Peter Anvin)  wrote on 15.05.01 in <3B01A044.F72BFDD1@transmeta.com>:

> Personally, I would also like to see network devices manifest in the
> filesystem namespace like everything else.

Yes.

Can we have a meta-rule?

*Every* by-name kernel interface should have a filesystem variant.

That is, if there's a kernel interface where you give the kernel a string  
to identify an in-kernel object, there should be some place in the file  
system (after mounting any prerequisites) that will respond to a path  
ending in that name.

That doesn't necessarily mean the parent will be a readable directory -  
that would, of course, be preferrable, but if enumerating all objects is a  
problem, then dropping this requirement is much preferrable to not having  
a pathname.

MfG Kai
