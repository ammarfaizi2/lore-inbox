Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319815AbSIMWbE>; Fri, 13 Sep 2002 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319811AbSIMWbE>; Fri, 13 Sep 2002 18:31:04 -0400
Received: from smtp2.san.rr.com ([24.25.195.39]:18860 "EHLO smtp2.san.rr.com")
	by vger.kernel.org with ESMTP id <S319806AbSIMWbC>;
	Fri, 13 Sep 2002 18:31:02 -0400
Date: Fri, 13 Sep 2002 15:28:35 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: qlogic failover multipath
Message-ID: <20020913222835.GB4315@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20020906153437.GA2164@beaverton.ibm.com> <Pine.LNX.4.44.0209070822250.21784-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209070822250.21784-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18-4GB
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Sep 2002, Oktay Akbal wrote:

> On Fri, 6 Sep 2002, Mike Anderson wrote:
> 
> > You can edit the qla_settings.h file and set MPIO_SUPPORT to 1 or I
> > believe if you use the qla2x00src-v6.1b5-fo archive that this should
> > already be set to 1.
> 
> Thank you, I will try at Monday. It is set to 0 in b5.
> But my archive is named: qla2x00src-v6.1b5.tgz
> -fo seems to come only from enabling MPIO ?
>
The only functional difference between the -fo package referenced by 
Mike Anderson and the non-fo (qla2x00src-v6.1b5.tgz) available from
the QLogic download site is:

	o MPIO_SUPPORT always set to 1
	o Different README files.

Thus, multipathing support can be enabled with standard package.

Regards,
-- 
Andrew Vasquez | praka@san.rr.com |
	I prefer an accomidating vice to an obstinate virtue
DSS: 0x508316BB, FP: 79BD 4FAC 7E82 FF70 6C2B  7E8B 168F 5529 5083 16BB
