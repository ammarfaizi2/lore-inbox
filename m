Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275970AbRI1H4o>; Fri, 28 Sep 2001 03:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275969AbRI1H4e>; Fri, 28 Sep 2001 03:56:34 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:44044
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S275970AbRI1H43>; Fri, 28 Sep 2001 03:56:29 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109280738.f8S7cQr17973@www.hockin.org>
Subject: Re: copy_from_user() overhead
To: rmurali@iastate.edu (Murali Ravirala)
Date: Fri, 28 Sep 2001 00:38:26 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, rmurali@iastate.edu
In-Reply-To: <200109280657.f8S6vbBG010382@mailhub-2.iastate.edu> from "Murali Ravirala" at Sep 28, 2001 01:57:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are interested in finding out the overhead in kernel->user buffer copy and
> vice-versa for disk reads and network writes resp. in copy_from_user() and
> copy_to_user() calls. Are there any quantitative data available for this? We
> plan to eliminate this overhead, if significant, in our integrated disk-read and
> network-write architecture. Any pointers/references related to this type of
> work?

Perhaps you are thinking of something like IO-Lite?  Has anyone in the
linux world ever implemented IO-Lite?  Sure would be interesting to have
essentially zero-copy file operations..
